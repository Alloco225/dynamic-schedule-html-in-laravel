<!-- Html Icon Field -->
<div class="col-sm-12">
    {!! Form::label('html_icon', 'Html Icon:') !!}
    <p>{{ $profileSkill->html_icon }}</p>
</div>

<!-- Image Icon Field -->
<div class="col-sm-12">
    {!! Form::label('image_icon', 'Image Icon:') !!}
    <p>{{ $profileSkill->image_icon }}</p>
</div>

<!-- Label Field -->
<div class="col-sm-12">
    {!! Form::label('label', 'Label:') !!}
    <p>{{ $profileSkill->label }}</p>
</div>

<!-- Value Field -->
<div class="col-sm-12">
    {!! Form::label('value', 'Value:') !!}
    <p>{{ $profileSkill->value }}</p>
</div>

<!-- Created At Field -->
<div class="col-sm-12">
    {!! Form::label('created_at', 'Created At:') !!}
    <p>{{ $profileSkill->created_at }}</p>
</div>

<!-- Updated At Field -->
<div class="col-sm-12">
    {!! Form::label('updated_at', 'Updated At:') !!}
    <p>{{ $profileSkill->updated_at }}</p>
</div>

