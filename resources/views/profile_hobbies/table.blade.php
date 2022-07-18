<div class="table-responsive">
    <table class="table" id="profileHobbies-table">
        <thead>
            <tr>
                <th>Profile Id</th>
        <th>Html Icon</th>
        <th>Html Image</th>
        <th>Label</th>
                <th colspan="3">Action</th>
            </tr>
        </thead>
        <tbody>
        @foreach($profileHobbies as $profileHobby)
            <tr>
                <td>{{ $profileHobby->profile_id }}</td>
            <td>{{ $profileHobby->html_icon }}</td>
            <td>{{ $profileHobby->html_image }}</td>
            <td>{{ $profileHobby->label }}</td>
                <td width="120">
                    {!! Form::open(['route' => ['profileHobbies.destroy', $profileHobby->id], 'method' => 'delete']) !!}
                    <div class='btn-group'>
                        <a href="{{ route('profileHobbies.show', [$profileHobby->id]) }}" class='btn btn-default btn-xs'>
                            <i class="far fa-eye"></i>
                        </a>
                        <a href="{{ route('profileHobbies.edit', [$profileHobby->id]) }}" class='btn btn-default btn-xs'>
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
