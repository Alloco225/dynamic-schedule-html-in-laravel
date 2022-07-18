                    <span  {{ $attributes->merge(['class' => 'cursor-pointer']) }} >
                        <i class="material-icons" x-show="isOpen == false">keyboard_arrow_down</i>
                        <i class="material-icons" x-show="isOpen == true">keyboard_arrow_up</i>
                    </span>
