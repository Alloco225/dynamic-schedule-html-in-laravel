<div class="table-responsive">
    <table class="table" id="profileSkills-table">
        <thead>
            <tr>
                <th>Html Icon</th>
        <th>Image Icon</th>
        <th>Label</th>
        <th>Value</th>
                <th colspan="3">Action</th>
            </tr>
        </thead>
        <tbody>
        @foreach($profileSkills as $profileSkill)
            <tr>
                <td>{{ $profileSkill->html_icon }}</td>
            <td>{{ $profileSkill->image_icon }}</td>
            <td>{{ $profileSkill->label }}</td>
            <td>{{ $profileSkill->value }}</td>
                <td width="120">
                    {!! Form::open(['route' => ['profileSkills.destroy', $profileSkill->id], 'method' => 'delete']) !!}
                    <div class='btn-group'>
                        <a href="{{ route('profileSkills.show', [$profileSkill->id]) }}" class='btn btn-default btn-xs'>
                            <i class="far fa-eye"></i>
                        </a>
                        <a href="{{ route('profileSkills.edit', [$profileSkill->id]) }}" class='btn btn-default btn-xs'>
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
