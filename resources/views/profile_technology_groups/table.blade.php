<div class="table-responsive">
    <table class="table" id="profileTechnologyGroups-table">
        <thead>
            <tr>
                <th>Profile Id</th>
        <th>Html Icon</th>
        <th>Label</th>
        <th>Value</th>
                <th colspan="3">Action</th>
            </tr>
        </thead>
        <tbody>
        @foreach($profileTechnologyGroups as $profileTechnologyGroup)
            <tr>
                <td>{{ $profileTechnologyGroup->profile_id }}</td>
            <td>{{ $profileTechnologyGroup->html_icon }}</td>
            <td>{{ $profileTechnologyGroup->label }}</td>
            <td>{{ $profileTechnologyGroup->value }}</td>
                <td width="120">
                    {!! Form::open(['route' => ['profileTechnologyGroups.destroy', $profileTechnologyGroup->id], 'method' => 'delete']) !!}
                    <div class='btn-group'>
                        <a href="{{ route('profileTechnologyGroups.show', [$profileTechnologyGroup->id]) }}" class='btn btn-default btn-xs'>
                            <i class="far fa-eye"></i>
                        </a>
                        <a href="{{ route('profileTechnologyGroups.edit', [$profileTechnologyGroup->id]) }}" class='btn btn-default btn-xs'>
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
