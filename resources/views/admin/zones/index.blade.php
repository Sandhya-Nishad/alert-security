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
                                    <th>@lang('S.N.')</th>
                                    <th>@lang('Name')</th>
                                    <th>@lang('Address')</th>
                                    <th>@lang('Site Names')</th>
                                    <th>@lang('Status')</th>
                                    <th>@lang('Action')</th>
                                </tr>
                            </thead>
                            <tbody>
                                @forelse($zones as $zone)
                                    <tr>
                                        <td>{{ $zones->firstItem() + $loop->index }}</td>
                                        <td>{{ $zone->name }}</td>
                                        <td>{{ $zone->address }}</td>
                                        <td>
                                            @if($zone->sites && $zone->sites->count())
                                               <ul>
                            @foreach($zone->sites as $site)
                                <li>{{ $site->name }}</li>
                            @endforeach
                        </ul>
                                            @else
                                                <span class="text--muted">-</span>
                                            @endif
                                        </td>
                                        <td>
                                            @php echo $zone->statusBadge; @endphp
                                        </td>
                                        <td>
                                            <div class="button--group">
                                                @permit('admin.zones.store')
                                                    <button class="btn btn-sm btn-outline--primary editBtn cuModalBtn" data-id="{{ $zone->id }}" data-resource='@json($zone)' data-modal_title="@lang('Edit zone')" type="button">
                                                        <i class="la la-pencil"></i>@lang('Edit')
                                                    </button>
                                                @endpermit

                                                @permit('admin.zones.status')
                                                    @if($zone->status == 1)
                                                        <button class="btn btn-sm btn-outline--success ms-1 confirmationBtn" data-action="{{ route('admin.zones.status', $zone->id) }}" data-question="@lang('Are you sure to enable this zone')?" type="button">
                                                            <i class="la la-eye"></i> @lang('Enabled')
                                                        </button>
                                                    @else
                                                        <button class="btn btn-sm btn-outline--danger confirmationBtn" data-action="{{ route('admin.zones.status', $zone->id) }}" data-question="@lang('Are you sure to disable this zone')?" type="button">
                                                            <i class="la la-eye-slash"></i> @lang('Disabled')
                                                        </button>
                                                    @endif
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
                        </table><!-- table end -->
                    </div>
                </div>
                @if ($zones->hasPages())
                    <div class="card-footer d-flex justify-content-center py-4">
                        @php echo paginateLinks($zones) @endphp
                    </div>
                @endif
            </div><!-- card end -->
        </div>
    </div>

    <div class="modal fade" id="importModal" role="dialog" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title">@lang('Import Warehouse')</h4>
                    <button class="close" data-bs-dismiss="modal" type="button" aria-label="Close">
                        <i class="la la-times" aria-hidden="true"></i>
                    </button>
                </div>
                <form id="importForm" method="post" action="{{ route('admin.zones.import') }}" enctype="multipart/form-data">
                    @csrf
                    <div class="modal-body">
                        <div class="form-group">
                            <div class="alert alert-warning p-3" role="alert">
                                <p>
                                    - @lang('Format your CSV the same way as the sample file below.') <br>
                                    - @lang('Valid fields Tip: make sure name of fields must be following: name, address')<br>
                                    - @lang('Required (name) ,Optional (address), Unique (name)')<br>
                                    - @lang('When an error occurs download the error file and correct the incorrect cells and import that file again through format.')<br>
                                </p>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="fw-bold">@lang('Select File')</label>
                            <input class="form-control" name="file" type="file" accept=".csv" required>
                            <div class="mt-1">
                                <small class="d-block">
                                    @lang('Supported files:') <b class="fw-bold">@lang('csv')</b>
                                </small>
                                <small>
                                    @lang('Download sample template file from here')
                                    <a class="text--primary" href="{{ asset('assets/files/sample/warehouse.csv') }}" title="@lang('Download csv file')" download>
                                        <b>@lang('warehouse.csv')</b>
                                    </a>

                                </small>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button class="btn btn--primary w-100 h-45" type="Submit">@lang('Import')</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!--Cu Modal -->
    <div class="modal fade" id="cuModal" role="dialog" tabindex="-1">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title"></h5>
                    <button class="close" data-bs-dismiss="modal" type="button" aria-label="Close">
                        <i class="las la-times"></i>
                    </button>
                </div>
                <form action="{{ route('admin.zones.store') }}" method="POST" enctype="multipart/form-data">
                    @csrf
                    <div class="modal-body">
                        <div class="form-group zone-selection-group">
                            <label>@lang('Zone Selection')</label>
                            <div class="d-flex">
                                <div class="form-check me-3">
                                    <input class="form-check-input" type="radio" name="zone_type" id="new_zone" value="new" checked>
                                    <label class="form-check-label" for="new_zone">@lang('Add New Zone')</label>
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" name="zone_type" id="existing_zone" value="existing">
                                    <label class="form-check-label" for="existing_zone">@lang('Add to Existing Zone')</label>
                                </div>
                            </div>
                        </div>
                        
                        <!-- New Zone Form Fields -->
                        <div id="new_zone_fields">
                            <div class="form-group">
                                <label>@lang('New Zone Name')</label>
                                <input class="form-control" name="name" type="text" value="{{ old('name') }}" required>
                            </div>
                            <div class="form-group">
                                <label>@lang('New Zone Address')</label>
                                <input class="form-control" name="address" type="text" value="{{ old('address') }}" required>
                            </div>
                        </div>
                        
                        <!-- Existing Zone Selection -->
                        <div id="existing_zone_fields" style="display: none;">
                            <div class="form-group">
                                <label>@lang('Select Existing Zone')</label>
                                <select class="form-control" name="existing_zone_id" id="existing_zone_select">
                                    <option value="">@lang('Select a zone...')</option>
                                    <!-- Zone options will be loaded via JavaScript -->
                                </select>
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label>@lang('Site Name(s)')</label>
                            <textarea class="form-control" name="sitename" rows="3" placeholder="@lang('e.g., Site 1, Site 2, Site 3')" required>{{ old('sitename') }}</textarea>
                            <small class="text-muted">@lang('Enter multiple site names separated by commas. Each site will be created under this zone.')</small>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button class="btn btn--primary h-45 w-100" type="submit">@lang('Submit')</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <x-confirmation-modal />
@endsection

@push('breadcrumb-plugins')
    <x-search-form />

    @permit('admin.zones.store')
        <button class="btn btn-sm btn-outline--primary h-45 cuModalBtn" data-modal_title="@lang('Add New Zone')" type="button">
            <i class="la la-plus"></i>@lang('Add New')
        </button>
    @endpermit
    @permit('admin.zones.import')
        <button class="btn btn-sm btn-outline--info importBtn" type="button">
            <i class="las la-cloud-upload-alt"></i>@lang('Import CSV')
        </button>
    @endpermit
@endpush

@push('script')
    <script>
        (function($) {
            "use strict";
            
            // Define the function to load zones
            function loadZones() {
                $.get('{{ route("admin.zones.getZones") }}', function(response) {
                    const select = $('#existing_zone_select');
                    select.empty();
                    select.append('<option value="">@lang("Select a zone...")</option>');
                    
                    if (response.zones && response.zones.length > 0) {
                        response.zones.forEach(function(zone) {
                            select.append(`<option value="${zone.id}">${zone.name} - ${zone.address}</option>`);
                        });
                    }
                }).fail(function(xhr, status, error) {
                    console.error('Failed to load zones:', error);
                });
            }
            
            // Handle radio button selection to show/hide fields
            $('input[name="zone_type"]').on('change', function() {
                const zoneType = $(this).val();
                const nameField = $('input[name="name"]');
                const addressField = $('input[name="address"]');
                const existingZoneField = $('#existing_zone_select');
                
                if (zoneType === 'existing') {
                    $('#new_zone_fields').hide();
                    $('#existing_zone_fields').show();
                    
                    // Remove required from new zone fields
                    nameField.removeAttr('required');
                    addressField.removeAttr('required');
                    existingZoneField.attr('required', 'required');
                } else {
                    $('#new_zone_fields').show();
                    $('#existing_zone_fields').hide();
                    
                    // Add required to new zone fields
                    nameField.attr('required', 'required');
                    addressField.attr('required', 'required');
                    existingZoneField.removeAttr('required');
                }
            });
            
            // Load zones when modal is shown
            $('#cuModal').on('shown.bs.modal', function() {
                loadZones();
            });

            $(".importBtn").on('click', function(e) {
                let importModal = $("#importModal");
                importModal.modal('show');
            });

            // Reset modal when hidden
            $('#cuModal').on('hidden.bs.modal', function() {
                const form = $(this).find('form');
                form[0].reset();
                form.attr('action', '{{ route("admin.zones.store") }}');
                $('#new_zone').prop('checked', true);
                $('#new_zone_fields').show();
                $('#existing_zone_fields').hide();
                $('.zone-selection-group').show();
            });

            // When clicking edit button, pass zone id to the form action
            $(document).on('click', '.cuModalBtn', function() {
                const modal = $('#cuModal');
                const title = $(this).data('modal_title') || '@lang("Add New Zone")';
                modal.find('.modal-title').text(title);
                const zoneId = $(this).data('id') || 0;
                const resource = $(this).data('resource');
                const form = modal.find('form');
                
                if (zoneId && zoneId > 0) {
                    // Editing existing zone
                    form.attr('action', '{{ route("admin.zones.store") }}/' + zoneId);
                    
                    // Hide zone selection radio buttons when editing
                    $('.zone-selection-group').hide();
                    $('#new_zone_fields').show();
                    $('#existing_zone_fields').hide();
                    
                    // Pre-fill form with zone data
                    if (resource) {
                        form.find('input[name="name"]').val(resource.name);
                        form.find('input[name="address"]').val(resource.address);
                        
                        // If zone has sites, show them separated by commas
                        if (resource.sites && resource.sites.length > 0) {
                            const siteNames = resource.sites.map(site => site.name).join(', ');
                            form.find('textarea[name="sitename"]').val(siteNames);
                        } else {
                            form.find('textarea[name="sitename"]').val('');
                        }
                    }
                } else {
                    // Creating new zone
                    form.attr('action', '{{ route("admin.zones.store") }}');
                    form[0].reset();
                    $('.zone-selection-group').show();
                    $('#new_zone').prop('checked', true);
                    $('#new_zone_fields').show();
                    $('#existing_zone_fields').hide();
                }
                
                modal.modal('show');
            });

            // Handle zone form submission
            $('#cuModal form').on('submit', function(e) {
                const zoneType = $('input[name="zone_type"]:checked').val();
                const existingZoneId = $('#existing_zone_select').val();
                const name = $('input[name="name"]').val();
                const address = $('input[name="address"]').val();
                
                // Validation for new zone
                if (zoneType === 'new') {
                    if (!name || !name.trim()) {
                        e.preventDefault();
                        alert('@lang("Please enter zone name")');
                        return false;
                    }
                    if (!address || !address.trim()) {
                        e.preventDefault();
                        alert('@lang("Please enter zone address")');
                        return false;
                    }
                }
                
                // Validation for existing zone
                if (zoneType === 'existing') {
                    if (!existingZoneId) {
                        e.preventDefault();
                        alert('@lang("Please select an existing zone")');
                        return false;
                    }
                    
                    // Update form action to use the existing zone ID
                    const currentAction = $(this).attr('action');
                    const baseUrl = '{{ route("admin.zones.store") }}';
                    $(this).attr('action', baseUrl + '/' + existingZoneId);
                }
                
                // Let the form submit normally
                return true;
            });
        })(jQuery);
    </script>
@endpush