@extends('admin.layouts.app')
@section('panel')
    <div class="row">
        <div class="col-lg-12">
            <div class="card">
                <div class="card-body p-0">
                    <div class="table-responsive--md table-responsive">
                        <table class="table table--light style--two">
                            <thead>
                                <tr>
                                    <th>@lang('S.N')</th>
                                    <th>@lang('Image')</th>
                                    <th>@lang('Name')</th>
                                    <th>@lang('Email')</th>
                                    <th>@lang('Mobile')</th>
                                    <th>@lang('Zone/Site')</th>
                                    <th>@lang('Receivable')</th>
                                    <th>@lang('Payable')</th>
                                    <th>@lang('Action')</th>
                                </tr>
                            </thead>
                            <tbody>
                                @forelse($customers as $customer)
                                    <tr>
                                        <td>{{ $customers->firstItem() + $loop->index }}</td>
                                        <td>
                                            @if($customer->photo)
                                                <img src="{{ getImage(getFilePath('customer').'/'. $customer->photo, '100x100') }}" alt="Customer Photo" style="width:40px;height:40px;object-fit:cover;border-radius:5px;">
                                            @else
                                                <span class="text-muted">@lang('No Image')</span>
                                            @endif
                                        </td>
                                        <td>
                                            <span class="fw-bold">{{ $customer->name }}</span>
                                            <br>
                                            <small class="text-muted">{{ strLimit($customer->address, 40) }}</small>
                                        </td>
                                        <td>{{ $customer->email }}</td>
                                        <td>
                                            <span class="fw-bold">+{{ $customer->mobile }}</span>
                                        </td>
                                        <td>
                                            @if($customer->zone)
                                                <span class="badge bg--primary">{{ $customer->zone->address }}</span>
                                            @endif
                                            @if($customer->site)
                                                <br><span class="badge bg--info mt-1">{{ $customer->site->name }}</span>
                                            @endif
                                        </td>
                                        <td>{{ showAmount($customer->totalReceivableAmount()) }}</td>
                                        <td>{{ showAmount($customer->totalPayableAmount()) }}</td>
                                        <td>
                                            <div class="button--group">
                                                <button type="button" class="btn btn-sm btn-outline--primary cuModalBtn"
                                                    data-modal_title="@lang('Edit Customer')" 
                                                    data-id="{{ $customer->id }}"
                                                    data-resource='@json($customer)'>
                                                    <i class="la la-pencil"></i>@lang('Edit')
                                                </button>
                                                @permit('admin.customer.notification.log')
                                                    <a class="btn btn-sm btn-outline--warning"
                                                        href="{{ route('admin.customer.notification.log', $customer->id) }}">
                                                        <i class="la la-bell"></i>@lang('Notify')
                                                    </a>
                                                @endpermit
                                                @php
                                                    $totalReceivable = $customer->totalReceivableAmount() - abs($customer->totalPayableAmount());
                                                @endphp
                                                @permit('admin.customer.payment.index')
                                                    <a href="{{ route('admin.customer.payment.index', $customer->id) }}" @class([
                                                        'btn btn-sm btn-outline--info',
                                                        'disabled' => $totalReceivable == 0,
                                                    ])>
                                                        <i class="las la-money-bill-wave-alt"></i>@lang('Payment')
                                                    </a>
                                                @endpermit
                                            </div>
                                        </td>
                                    </tr>
                                @empty
                                    <tr>
                                        <td class="text-muted text-center" colspan="100%">{{ __($emptyMessage) }}</td>
                                    </tr>
                                @endforelse
                            </tbody>
                        </table>
                    </div>
                </div>
                @if ($customers->hasPages())
                    <div class="card-footer py-4">
                        @php echo paginateLinks($customers) @endphp
                    </div>
                @endif
            </div>
        </div>
    </div>

    <!-- Create Update Modal -->
    <div class="modal fade" id="cuModal">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title"></h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <i class="las la-times"></i>
                    </button>
                </div>

                <form action="{{ route('admin.customer.store') }}" method="POST" enctype="multipart/form-data">
                    @csrf
                    <input type="hidden" name="customer_id" id="customer_id" value="">
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-lg-6">
                                <div class="form-group">
                                    <label>@lang('Name') <span class="text-danger">*</span></label>
                                    <input type="text" name="name" class="form-control" autocomplete="off" value="{{ old('name') }}" required>
                                </div>
                            </div>
                            <div class="col-lg-6">
                                <div class="form-group">
                                    <label class="form-label">@lang('Email') <span class="text-danger">*</span></label>
                                    <input type="email" class="form-control" name="email" value="{{ old('email') }}" required>
                                </div>
                            </div>

                            <div class="col-lg-6">
                                <div class="form-group">
                                    <label class="form-label">@lang('Mobile') <span class="text-danger">*</span>
                                        <i class="fa fa-info-circle text--primary" title="@lang('Type the mobile number including the country code. Otherwise, SMS won\'t send to that number.')"></i>
                                    </label>
                                    <input type="number" name="mobile" value="{{ old('mobile') }}" class="form-control" required>
                                </div>
                            </div>

                            <div class="col-lg-6">
                                <div class="form-group">
                                    <label>@lang('Address')</label>
                                    <input type="text" name="address" class="form-control" value="{{ old('address') }}">
                                </div>
                            </div>
                            
                            <div class="col-lg-6">
                                <div class="form-group">
                                    <label>@lang('Zone') <span class="text-danger">*</span></label>
                                    <select name="zone_id" id="zoneSelect" class="form-control" required>
                                        <option value="">@lang('Select Zone')</option>
                                        @foreach($zones ?? [] as $zone)
                                            <option value="{{ $zone->id }}" {{ old('zone_id') == $zone->id ? 'selected' : '' }}>
                                                {{ $zone->address }}
                                            </option>
                                        @endforeach
                                    </select>
                                </div>
                            </div>
                            
                            <div class="col-lg-6">
                                <div class="form-group">
                                    <label>@lang('Site Name') <span class="text-danger">*</span></label>
                                    <select name="site_id" id="siteSelect" class="form-control" required>
                                        <option value="">@lang('Select Site')</option>
                                    </select>
                                </div>
                            </div>
                            
                            <div class="col-lg-6">
                                <div class="form-group">
                                    <label>@lang('Photo')</label>
                                    <input type="file" name="photo" class="form-control" accept="image/*">
                                    <small class="text-muted">@lang('Supported: JPG, JPEG, PNG. Max: 2MB')</small>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    @permit('admin.customer.store')
                        <div class="modal-footer">
                            <button type="submit" class="btn btn--primary w-100 h-45">@lang('Submit')</button>
                        </div>
                    @endpermit
                </form>
            </div>
        </div>
    </div>

    {{-- IMPORT MODAL --}}
    <div class="modal fade" id="importModal" tabindex="-1" role="dialog">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title">@lang('Import Customer')</h4>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <i class="la la-times" aria-hidden="true"></i>
                    </button>
                </div>
                <form method="post" action="{{ route('admin.customer.import') }}" id="importForm" enctype="multipart/form-data">
                    @csrf
                    <div class="modal-body">
                        <div class="form-group">
                            <div class="alert alert-warning p-3" role="alert">
                                <p>
                                    - @lang('Format your CSV the same way as the sample file below.') <br>
                                    - @lang('The number of columns in your CSV should be the same as the example below.')<br>
                                    - @lang('Valid fields Tip: make sure name of fields must be following: name, email, mobile, address')<br>
                                    - @lang("Required all field's, Unique Field's (email, mobile) column cell must not be empty.")<br>
                                </p>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="fw-bold">@lang('Select File')</label>
                            <input type="file" class="form-control" name="file" accept=".csv" required>
                            <div class="mt-1">
                                <small class="d-block">
                                    @lang('Supported files:') <b class="fw-bold">@lang('csv')</b>
                                </small>
                                <small>
                                    @lang('Download sample template file from here')
                                    <a href="{{ asset('assets/files/sample/customer.csv') }}" title="@lang('Download csv file')" class="text--primary" download>
                                        <b>@lang('customer.csv')</b>
                                    </a>
                                </small>
                            </div>
                        </div>
                    </div>
                    @permit('admin.customer.import')
                        <div class="modal-footer">
                            <button type="Submit" class="btn btn--primary w-100 h-45">@lang('Import')</button>
                        </div>
                    @endpermit
                </form>
            </div>
        </div>
    </div>
@endsection

@push('breadcrumb-plugins')
    <x-search-form />
    @permit('admin.customer.store')
        <button type="button" class="btn btn-sm btn-outline--primary cuModalBtn" data-modal_title="@lang('Add New Customer')">
            <i class="la la-plus"></i>@lang('Add New')
        </button>
    @endpermit
    @permit('admin.customer.notification.all')
        <a class="btn btn-sm btn-outline--info" href="{{ route('admin.customer.notification.all') }}">
            <i class="la la-bell"></i>@lang('Notification to All')
        </a>
    @endpermit

    @php
        $params = request()->all();
    @endphp
    @permit(['admin.customer.pdf', 'admin.customer.csv', 'admin.customer.import'])
        <div class="btn-group">
            <button type="button" class="btn btn-outline--success dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
                @lang('Action')
            </button>
            <ul class="dropdown-menu">
                @permit('admin.customer.pdf')
                    <li>
                        <a class="dropdown-item" href="{{ route('admin.customer.pdf', $params) }}">
                            <i class="la la-download"></i>@lang('Download PDF')
                        </a>
                    </li>
                @endpermit
                @permit('admin.customer.csv')
                    <li>
                        <a class="dropdown-item" href="{{ route('admin.customer.csv', $params) }}">
                            <i class="la la-download"></i>@lang('Download CSV')
                        </a>
                    </li>
                @endpermit
                @permit('admin.customer.import')
                    <li>
                        <a class="dropdown-item importBtn" href="javascript:void(0)">
                            <i class="las la-cloud-upload-alt"></i> @lang('Import CSV')
                        </a>
                    </li>
                @endpermit
            </ul>
        </div>
    @endpermit
@endpush

@push('script')
    <script>
        (function($) {
            "use strict";
            
            // Sites data passed from controller
            const SITES = @json($sites ?? []);

            // Import modal trigger
            $(".importBtn").on('click', function(e) {
                $("#importModal").modal('show');
            });

            // Populate sites based on selected zone
            function populateSites(zoneId, selectedSiteId = null) {
                const siteSelect = $('#siteSelect');
                siteSelect.empty();
                siteSelect.append('<option value="">@lang("Select Site")</option>');
                
                if (!zoneId) {
                    siteSelect.prop('required', false);
                    return;
                }
                
                const sites = SITES[zoneId] || {};
                if (Object.keys(sites).length === 0) {
                    siteSelect.append('<option value="">@lang("No sites available for this zone")</option>');
                    siteSelect.prop('required', false);
                    return;
                }
                
                $.each(sites, function(id, name) {
                    const opt = $('<option>', { 
                        value: id, 
                        text: name 
                    });
                    if (selectedSiteId && selectedSiteId == id) {
                        opt.prop('selected', true);
                    }
                    siteSelect.append(opt);
                });
                
                siteSelect.prop('required', true);
            }

            // On zone change, update sites dropdown
            $(document).on('change', '#zoneSelect', function() {
                const zoneId = $(this).val();
                populateSites(zoneId);
            });

            // Reset modal on close
            $('#cuModal').on('hidden.bs.modal', function() {
                const form = $(this).find('form');
                form[0].reset();
                form.attr('action', '{{ route("admin.customer.store") }}');
                $('#customer_id').val('');
                $('#siteSelect').empty().append('<option value="">@lang("Select Site")</option>');
            });

            // When opening create/edit modal
            $(document).on('click', '.cuModalBtn', function() {
                const modal = $('#cuModal');
                const title = $(this).data('modal_title') || '@lang("Add New Customer")';
                modal.find('.modal-title').text(title);
                
                const customerId = $(this).data('id');
                const resource = $(this).data('resource');
                
                if (customerId && resource) {
                    // Editing existing customer
                    $('#customer_id').val(customerId);
                    modal.find('form').attr('action', '{{ route("admin.customer.store") }}/' + customerId);
                    
                    // Populate form fields
                    modal.find('input[name="name"]').val(resource.name || '');
                    modal.find('input[name="email"]').val(resource.email || '');
                    modal.find('input[name="mobile"]').val(resource.mobile || '');
                    modal.find('input[name="address"]').val(resource.address || '');
                    
                    // Set zone and populate sites
                    if (resource.zone_id) {
                        modal.find('select[name="zone_id"]').val(resource.zone_id);
                        populateSites(resource.zone_id, resource.site_id || null);
                    } else {
                        populateSites('');
                    }
                } else {
                    // Creating new customer
                    $('#customer_id').val('');
                    modal.find('form')[0].reset();
                    modal.find('form').attr('action', '{{ route("admin.customer.store") }}');
                    populateSites('');
                }
                
                modal.modal('show');
            });
        })(jQuery);
    </script>
@endpush