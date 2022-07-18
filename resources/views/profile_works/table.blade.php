<div class="table-responsive">
    <table class="table" id="profileWorks-table">
        <thead>
            <tr>
                <th>Profile Id</th>
        <th>Label</th>
        <th>Thumbnail</th>
        <th>Logo</th>
        <th>Image</th>
        <th>Cover</th>
        <th>Description</th>
        <th>Url</th>
                <th colspan="3">Action</th>
            </tr>
        </thead>
        <tbody>
        @foreach($profileWorks as $profileWork)
            <tr>
                <td>{{ $profileWork->profile_id }}</td>
            <td>{{ $profileWork->label }}</td>
            <td>{{ $profileWork->thumbnail }}</td>
            <td>{{ $profileWork->logo }}</td>
            <td>{{ $profileWork->image }}</td>
            <td>{{ $profileWork->cover }}</td>
            <td>{{ $profileWork->description }}</td>
            <td>{{ $profileWork->url }}</td>
                <td width="120">
                    {!! Form::open(['route' => ['profileWorks.destroy', $profileWork->id], 'method' => 'delete']) !!}
                    <div class='btn-group'>
                        <a href="{{ route('profileWorks.show', [$profileWork->id]) }}" class='btn btn-default btn-xs'>
                            <i class="far fa-eye"></i>
                        </a>
                        <a href="{{ route('profileWorks.edit', [$profileWork->id]) }}" class='btn btn-default btn-xs'>
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
