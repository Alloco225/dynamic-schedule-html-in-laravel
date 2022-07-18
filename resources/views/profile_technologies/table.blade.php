<div class="table-responsive">
    <table class="table" id="profileTechnologies-table">
        <thead>
            <tr>
                <th>Html Image</th>
        <th>Image Url</th>
        <th>Label</th>
        <th>Progress</th>
                <th colspan="3">Action</th>
            </tr>
        </thead>
        <tbody>
        @foreach($profileTechnologies as $profileTechnology)
            <tr>
                <td>{{ $profileTechnology->html_image }}</td>
            <td>{{ $profileTechnology->image_url }}</td>
            <td>{{ $profileTechnology->label }}</td>
            <td>{{ $profileTechnology->progress }}</td>
                <td width="120">
                    {!! Form::open(['route' => ['profileTechnologies.destroy', $profileTechnology->id], 'method' => 'delete']) !!}
                    <div class='btn-group'>
                        <a href="{{ route('profileTechnologies.show', [$profileTechnology->id]) }}" class='btn btn-default btn-xs'>
                            <i class="far fa-eye"></i>
                        </a>
                        <a href="{{ route('profileTechnologies.edit', [$profileTechnology->id]) }}" class='btn btn-default btn-xs'>
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
