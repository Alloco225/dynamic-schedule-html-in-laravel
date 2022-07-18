<div class="table-responsive">
    <table class="table" id="profiles-table">
        <thead>
            <tr>
                <th>Name</th>
        <th>First Name</th>
        <th>Last Name</th>
        <th>Picture</th>
        <th>About</th>
                <th colspan="3">Action</th>
            </tr>
        </thead>
        <tbody>
        @foreach($profiles as $profile)
            <tr>
                <td>{{ $profile->name }}</td>
            <td>{{ $profile->first_name }}</td>
            <td>{{ $profile->last_name }}</td>
            <td>{{ $profile->picture }}</td>
            <td>{{ $profile->about }}</td>
                <td width="120">
                    {!! Form::open(['route' => ['profiles.destroy', $profile->id], 'method' => 'delete']) !!}
                    <div class='btn-group'>
                        <a href="{{ route('profiles.show', [$profile->id]) }}" class='btn btn-default btn-xs'>
                            <i class="far fa-eye"></i>
                        </a>
                        <a href="{{ route('profiles.edit', [$profile->id]) }}" class='btn btn-default btn-xs'>
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
