<!-- Html Image Field -->
<div class="col-sm-12">
    {!! Form::label('html_image', 'Html Image:') !!}
    <p>{{ $profileTechnology->html_image }}</p>
</div>

<!-- Image Url Field -->
<div class="col-sm-12">
    {!! Form::label('image_url', 'Image Url:') !!}
    <p>{{ $profileTechnology->image_url }}</p>
</div>

<!-- Label Field -->
<div class="col-sm-12">
    {!! Form::label('label', 'Label:') !!}
    <p>{{ $profileTechnology->label }}</p>
</div>

<!-- Progress Field -->
<div class="col-sm-12">
    {!! Form::label('progress', 'Progress:') !!}
    <p>{{ $profileTechnology->progress }}</p>
</div>

<!-- Created At Field -->
<div class="col-sm-12">
    {!! Form::label('created_at', 'Created At:') !!}
    <p>{{ $profileTechnology->created_at }}</p>
</div>

<!-- Updated At Field -->
<div class="col-sm-12">
    {!! Form::label('updated_at', 'Updated At:') !!}
    <p>{{ $profileTechnology->updated_at }}</p>
</div>

