<!-- Name Field -->
<div class="col-sm-12">
    {!! Form::label('name', 'Name:') !!}
    <p>{{ $profile->name }}</p>
</div>

<!-- First Name Field -->
<div class="col-sm-12">
    {!! Form::label('first_name', 'First Name:') !!}
    <p>{{ $profile->first_name }}</p>
</div>

<!-- Last Name Field -->
<div class="col-sm-12">
    {!! Form::label('last_name', 'Last Name:') !!}
    <p>{{ $profile->last_name }}</p>
</div>

<!-- Picture Field -->
<div class="col-sm-12">
    {!! Form::label('picture', 'Picture:') !!}
    <p>{{ $profile->picture }}</p>
</div>

<!-- About Field -->
<div class="col-sm-12">
    {!! Form::label('about', 'About:') !!}
    <p>{{ $profile->about }}</p>
</div>

<!-- Created At Field -->
<div class="col-sm-12">
    {!! Form::label('created_at', 'Created At:') !!}
    <p>{{ $profile->created_at }}</p>
</div>

<!-- Updated At Field -->
<div class="col-sm-12">
    {!! Form::label('updated_at', 'Updated At:') !!}
    <p>{{ $profile->updated_at }}</p>
</div>

