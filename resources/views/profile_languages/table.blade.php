<div class="table-responsive">
    <table class="table" id="profileLanguages-table">
        <thead>
            <tr>
                <th>Profile Id</th>
        <th>Html Icon</th>
        <th>Label</th>
        <th>Progress</th>
        <th>Value</th>
                <th colspan="3">Action</th>
            </tr>
        </thead>
        <tbody>
        @foreach($profileLanguages as $profileLanguage)
            <tr>
                <td>{{ $profileLanguage->profile_id }}</td>
            <td>{{ $profileLanguage->html_icon }}</td>
            <td>{{ $profileLanguage->label }}</td>
            <td>{{ $profileLanguage->progress }}</td>
            <td>{{ $profileLanguage->value }}</td>
                <td width="120">
                    {!! Form::open(['route' => ['profileLanguages.destroy', $profileLanguage->id], 'method' => 'delete']) !!}
                    <div class='btn-group'>
                        <a href="{{ route('profileLanguages.show', [$profileLanguage->id]) }}" class='btn btn-default btn-xs'>
                            <i class="far fa-eye"></i>
                        </a>
                        <a href="{{ route('profileLanguages.edit', [$profileLanguage->id]) }}" class='btn btn-default btn-xs'>
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
