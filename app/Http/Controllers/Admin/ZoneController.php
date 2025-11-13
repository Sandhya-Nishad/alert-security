<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Zone;
use Illuminate\Http\Request;

class ZoneController extends Controller
{
    public function index()
    {
        $pageTitle = 'All Zones';
        // eager load sites to avoid N+1 when showing site names in the list
        $zones = Zone::with('sites')->orderBy('id', 'desc')->paginate(getPaginate());

        return view('admin.zones.index', compact('pageTitle', 'zones'));
    }

    public function store(Request $request, $id = 0)
    {
        // Check if we're adding sites to an existing zone via form selection
        if ($request->has('existing_zone_id') && $request->filled('existing_zone_id')) {
            // Adding sites to an existing zone
            $existingZoneId = $request->input('existing_zone_id');
            $zone = Zone::findOrFail($existingZoneId);
            $notification = 'Sites added to zone successfully';
        } else {
            // Creating a new zone or editing an existing one via the edit button
            $request->validate([
                'name'    => 'required|string|max:100|unique:zones,name,' . $id,
                'address' => 'nullable|string|max:500',
                'sitename' => 'nullable|string'
            ]);

            // if not editing and address is provided, check if it already exists
            if (!$id && $request->filled('address')) {
                $existingZone = Zone::where('address', trim($request->address))->first();
                if ($existingZone) {
                    // return JSON response with existing zone info so frontend can ask user
                    return response()->json([
                        'status' => 'duplicate_address',
                        'message' => 'A zone with this address already exists.',
                        'existing_zone' => [
                            'id' => $existingZone->id,
                            'name' => $existingZone->name,
                            'address' => $existingZone->address,
                            'sites' => $existingZone->sites->pluck('name', 'id')->toArray()
                        ]
                    ], 200);
                }
            }

            if ($id) {
                $zone = Zone::findOrFail($id);
                $notification = 'Zone updated successfully';
            } else {
                $zone = new Zone();
                $notification = 'Zone added successfully';
            }

            $zone->name = $request->name;
            $zone->address = $request->address;
            $zone->save();
        }

        // handle sitename(s) - use comma as delimiter
        if ($request->filled('sitename')) {
            // First, delete existing sites for this zone (if editing)
            if ($id) {
                \App\Models\Site::where('zone_id', $zone->id)->delete();
            }
            
            $sites = array_map('trim', explode(',', $request->sitename));
            foreach ($sites as $site) {
                $name = trim($site);
                if ($name) {
                    \App\Models\Site::create([
                        'zone_id' => $zone->id,
                        'name' => $name,
                    ]);
                }
            }
        }

        $notify[] = ['success', $notification];
        return to_route('admin.zones.index')->withNotify($notify);
    }

    public function import(Request $request)
    {
        $reqHeader    = ['name', 'address'];
        $importResult = importCSV($request, Zone::class, $reqHeader, $unique = "name");

        if ($importResult['data']) {
            $notify[] = ['success', $importResult['notify']];
        } else {
            $notify[] = ['error', 'No new data imported!'];
        }
        return back()->withNotify($notify);
    }

    public function status($id)
    {
        return Zone::changeStatus($id);
    }

    public function getZones()
    {
        $zones = Zone::orderBy('name')->get(['id', 'name', 'address']);
        return response()->json([
            'zones' => $zones
        ]);
    }
}
