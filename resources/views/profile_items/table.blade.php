<div class="table-responsive">
    <table class="table" id="profileItems-table">
        <thead>
            <tr>
                <th>Profile Id</th>
        <th>Html Icon</th>
        <th>Html Image</th>
        <th>Label</th>
        <th>Value</th>
        <th>Link</th>
                <th colspan="3">Action</th>
            </tr>
        </thead>
        <tbody>
        @foreach($profileItems as $profileItem)
            <tr>
                <td>{{ $profileItem->profile_id }}</td>
            <td>{{ $profileItem->html_icon }}</td>
            <td>{{ $profileItem->html_image }}</td>
            <td>{{ $profileItem->label }}</td>
            <td>{{ $profileItem->value }}</td>
            <td>{{ $profileItem->link }}</td>
                <td width="120">
                    {!! Form::open(['route' => ['profileItems.destroy', $profileItem->id], 'method' => 'delete']) !!}
                    <div class='btn-group'>
                        <a href="{{ route('profileItems.show', [$profileItem->id]) }}" class='btn btn-default btn-xs'>
                            <i class="far fa-eye"></i>
                        </a>
                        <a href="{{ route('profileItems.edit', [$profileItem->id]) }}" class='btn btn-default btn-xs'>
                            <i class="far fa-edit"></i>
                        </a>
                        {!! Form::button('<i class="far fa-trash-alt"></i>', ['type' => 'submit', 'class' => 'btn btn-danger btn-xs', 'onclick' => "return confirm('Are you sure?')"]) !!}
                    </div>
                    {!! Form::close() !!}
                </td>
            </tr>
        @endforeach
        </tbody>
    </table>
</div>
