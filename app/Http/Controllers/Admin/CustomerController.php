<?php

namespace App\Http\Controllers\Admin;

use App\Constants\Status;
use App\Http\Controllers\Controller;
use App\Models\Action;
use App\Models\Customer;
use Illuminate\Http\Request;
use App\Models\NotificationLog;
use App\Models\NotificationTemplate;

class CustomerController extends Controller
{
    protected $pageTitle;

    public function __construct()
    {
        $this->pageTitle = 'All Customers';
    }

    protected function getCustomers()
    {
        return Customer::searchable(['name', 'mobile', 'email', 'address'], false)
            ->with(['sale', 'saleReturns', 'zone', 'site'])
            ->orderBy('id', 'desc');
    }

    public function index()
    {
        $pageTitle = $this->pageTitle;
        $customers = $this->getCustomers()->paginate(getPaginate());
        
        // Load zones for customer create/edit modal (use address as option label)
        $zones = \App\Models\Zone::where('status', 1)->orderBy('address')->get();
        
        // Load sites grouped by zone id for frontend population
        $sites = \App\Models\Site::orderBy('name')->get()
            ->groupBy('zone_id')
            ->map(function($group) {
                return $group->mapWithKeys(function($item) { 
                    return [$item->id => $item->name]; 
                });
            })->toArray();

        return view('admin.customer.list', compact('pageTitle', 'customers', 'zones', 'sites'));
    }

    public function customerPDF()
    {
        $pageTitle = $this->pageTitle;
        $customers = $this->getCustomers()->get();
        return downloadPDF('pdf.customer.list', compact('pageTitle', 'customers'));
    }

    public function customerCSV()
    {
        $pageTitle = $this->pageTitle;
        $filename  = $this->downloadCsv($pageTitle, $this->getCustomers()->get());
        return response()->download(...$filename);
    }

    protected function downloadCsv($pageTitle, $data)
    {
        $filename = "assets/files/csv/example.csv";
        $myFile   = fopen($filename, 'w');
        $column   = "Name,Mobile,E-mail,Zone,Site,Receivable,Payable,Address\n";
        $curSym   = gs('cur_sym');
        
        foreach ($data as $customer) {
            $receivable = $curSym . getAmount($customer->totalReceivableAmount());
            $payable    = $curSym . getAmount($customer->totalPayableAmount());
            $address    = $customer->address;
            $zone       = $customer->zone ? $customer->zone->address : 'N/A';
            $site       = $customer->site ? $customer->site->name : 'N/A';

            $column .= "$customer->name,$customer->mobile,$customer->email,$zone,$site,$receivable,$payable,$address\n";
        }
        
        fwrite($myFile, $column);
        $headers = [
            'Content-Type' => 'application/csv',
        ];
        $name  = $pageTitle . time() . '.csv';
        $array = [$filename, $name, $headers];
        return $array;
    }

    public function store(Request $request, $id = 0)
    {
        $this->validation($request, $id);
        
        if ($id) {
            $notification = 'Customer updated successfully';
            $customer     = Customer::findOrFail($id);
        } else {
            // Check for existing mobile number
            $exist = Customer::where('mobile', $request->mobile)->first();
            if ($exist) {
                $notify[] = ['error', 'The mobile number already exists'];
                return back()->withNotify($notify);
            }
            $notification = 'Customer added successfully';
            $customer     = new Customer();
        }

        $customer->name    = $request->name;
        $customer->email   = strtolower(trim($request->email));
        $customer->mobile  = $request->mobile;
        $customer->address = $request->address;
        
        // Set zone_id and site_id from the form
        $customer->zone_id = $request->zone_id ?: null;
        $customer->site_id = $request->site_id ?: null;
        
        // Validate that site belongs to the selected zone
        if ($request->zone_id && $request->site_id) {
            $site = \App\Models\Site::where('id', $request->site_id)
                ->where('zone_id', $request->zone_id)
                ->first();
                
            if (!$site) {
                $notify[] = ['error', 'Selected site does not belong to the selected zone'];
                return back()->withNotify($notify)->withInput();
            }
        }
        
        $customer->id_number = $request->id_number ?: null;

        // Handle photo upload
        if ($request->hasFile('photo')) {
            try {
                $old = $id ? $customer->photo : null;
                $customer->photo = fileUploader($request->photo, getFilePath('customer'), getFileSize('customer'), $old);
            } catch (\Exception $e) {
                $notify[] = ['error', 'Photo upload failed: ' . $e->getMessage()];
                return back()->withNotify($notify)->withInput();
            }
        }

        $customer->save();

        // If id_number not provided, generate one based on the customer's DB id
        if (empty($customer->id_number)) {
            // Format: CUST0001 (adjust padding as needed)
            $generated = 'CUST' . str_pad($customer->id, 4, '0', STR_PAD_LEFT);
            $customer->id_number = $generated;
            $customer->save();
        }

        Action::newEntry($customer, $id ? 'UPDATED' : 'CREATED');

        $notify[] = ['success', $notification];
        return back()->withNotify($notify);
    }

    protected function validation($request, $id = 0)
    {
        $request->validate([
            'name'      => 'required|string|max:40',
            'email'     => 'required|string|email|unique:customers,email,' . $id,
            'mobile'    => 'required|regex:/^([0-9]*)$/|unique:customers,mobile,' . $id,
            'address'   => 'nullable|string|max:500',
            'zone_id'   => 'required|integer|exists:zones,id',
            'site_id'   => 'required|integer|exists:sites,id',
            'id_number' => 'nullable|string|max:100',
            'photo'     => 'nullable|image|mimes:jpg,jpeg,png|max:2048',
        ]);
    }

    public function list()
    {
        $customers = Customer::query();
        if (request()->search) {
            $customers->where(function ($q) {
                $q->where('email', 'like', '%' . request()->search . '%')
                  ->orWhere('name', 'like', '%' . request()->search . '%')
                  ->orWhere('mobile', 'like', '%' . request()->search . '%');
            });
        }

        $users = $customers->orderBy('id', 'desc')->paginate(getPaginate());
        return response()->json([
            'success' => true,
            'users'   => $users,
            'more'    => $users->hasMorePages()
        ]);
    }

    public function showNotificationSingleForm($id)
    {
        $customer = Customer::findOrFail($id);
        if (!gs('en') && !gs('sn')) {
            $notify[] = ['warning', 'Notification options are disabled currently'];
            return back()->withNotify($notify);
        }
        $pageTitle = 'Send Notification to ' . $customer->name;
        return view('admin.customer.notification_single', compact('pageTitle', 'customer'));
    }

    public function sendNotificationSingle(Request $request, $id)
    {
        $request->validate([
            'message' => 'required',
            'via'     => 'required|in:email,sms',
            'subject' => 'required_if:via,email',
        ]);

        if (!gs('en') && !gs('sn')) {
            $notify[] = ['warning', 'Notification options are disabled currently'];
            return to_route('admin.dashboard')->withNotify($notify);
        }

        $template = NotificationTemplate::where('act', 'DEFAULT')
            ->where($request->via . '_status', Status::ENABLE)
            ->exists();
            
        if (!$template) {
            $notify[] = ['warning', 'Default notification template is not enabled'];
            return back()->withNotify($notify);
        }

        $customer = Customer::findOrFail($id);
        notify($customer, 'DEFAULT', [
            'subject' => $request->subject,
            'message' => $request->message,
        ], [$request->via]);
        
        $notify[] = ['success', 'Notification sent successfully'];
        return back()->withNotify($notify);
    }

    public function showNotificationAllForm()
    {
        if (!gs('en') && !gs('sn')) {
            $notify[] = ['warning', 'Notification options are disabled currently'];
            return to_route('admin.dashboard')->withNotify($notify);
        }

        $notifyToUser = Customer::notifyToUser();
        $users        = Customer::count();
        $pageTitle    = 'Notification to Customer';

        if (session()->has('SEND_NOTIFICATION') && !request()->email_sent) {
            session()->forget('SEND_NOTIFICATION');
        }

        return view('admin.customer.notification_all', compact('pageTitle', 'users', 'notifyToUser'));
    }

    public function sendNotificationAll(Request $request)
    {
        $request->validate([
            'via'           => 'required|in:email,sms,push',
            'message'       => 'required',
            'subject'       => 'required_if:via,email,push',
            'start'         => 'required|integer|gte:1',
            'batch'         => 'required|integer|gte:1',
            'being_sent_to' => 'required',
            'cooling_time'  => 'required|integer|gte:1',
        ]);

        if (!gs('en') && !gs('sn') && !gs('pn')) {
            $notify[] = ['warning', 'Notification options are disabled currently'];
            return to_route('admin.dashboard')->withNotify($notify);
        }

        $template = NotificationTemplate::where('act', 'DEFAULT')
            ->where($request->via . '_status', Status::ENABLE)
            ->exists();
            
        if (!$template) {
            $notify[] = ['warning', 'Default notification template is not enabled'];
            return back()->withNotify($notify);
        }

        if ($request->being_sent_to == 'selectedUsers') {
            if (session()->has("SEND_NOTIFICATION")) {
                $request->merge(['user' => session()->get('SEND_NOTIFICATION')['user']]);
            } else {
                if (!$request->user || !is_array($request->user) || empty($request->user)) {
                    $notify[] = ['error', "Ensure that the user field is populated when sending an email to the designated user group"];
                    return back()->withNotify($notify);
                }
            }
        }

        $scope     = $request->being_sent_to;
        $userQuery = Customer::oldest()->$scope();

        if (session()->has("SEND_NOTIFICATION")) {
            $totalUserCount = session('SEND_NOTIFICATION')['total_user'];
        } else {
            $totalUserCount = (clone $userQuery)->count() - ($request->start - 1);
        }

        if ($totalUserCount <= 0) {
            $notify[] = ['error', "Notification recipients were not found among the selected user base."];
            return back()->withNotify($notify);
        }

        $users = (clone $userQuery)->skip($request->start - 1)->limit($request->batch)->get();

        foreach ($users as $user) {
            notify($user, 'DEFAULT', [
                'subject' => $request->subject,
                'message' => $request->message,
            ], [$request->via]);
        }

        return $this->sessionForNotification($totalUserCount, $request);
    }

    private function sessionForNotification($totalUserCount, $request)
    {
        if (session()->has('SEND_NOTIFICATION')) {
            $sessionData                = session("SEND_NOTIFICATION");
            $sessionData['total_sent'] += $sessionData['batch'];
        } else {
            $sessionData               = $request->except('_token');
            $sessionData['total_sent'] = $request->batch;
            $sessionData['total_user'] = $totalUserCount;
        }

        $sessionData['start'] = $sessionData['total_sent'] + 1;

        if ($sessionData['total_sent'] >= $totalUserCount) {
            session()->forget("SEND_NOTIFICATION");
            $message = ucfirst($request->via) . " notifications were sent successfully";
            $url     = route("admin.customer.notification.all");
        } else {
            session()->put('SEND_NOTIFICATION', $sessionData);
            $message = $sessionData['total_sent'] . " " . $sessionData['via'] . "  notifications were sent successfully";
            $url     = route("admin.customer.notification.all") . "?email_sent=yes";
        }
        
        $notify[] = ['success', $message];
        return redirect($url)->withNotify($notify);
    }

    public function notificationLog($id)
    {
        $customer  = Customer::findOrFail($id);
        $pageTitle = 'Notifications Sent to ' . $customer->name;
        $logs      = NotificationLog::where('customer_id', $id)
            ->with('customer')
            ->orderBy('id', 'desc')
            ->paginate(getPaginate());
            
        return view('admin.customer.notification_history', compact('pageTitle', 'logs', 'customer'));
    }

    public function emailDetails($id)
    {
        $pageTitle = 'Email Details';
        $email     = NotificationLog::findOrFail($id);
        return view('admin.customer.email_details', compact('pageTitle', 'email'));
    }

    public function import(Request $request)
    {
        $reqHeader    = ['name', 'email', 'mobile', 'address'];
        $importResult = importCSV($request, Customer::class, $reqHeader, $unique = "mobile");

        if ($importResult['data']) {
            $notify[] = ['success', $importResult['notify']];
        } else {
            $notify[] = ['error', 'No new data imported'];
        }
        
        return back()->withNotify($notify);
    }
}