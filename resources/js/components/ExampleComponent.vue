<template>
    <div>
        <div class="text-red-500">
            Hello, Example Component!
        </div>
        <div>
            {{message}}
        </div>
    </div>
</template>

<script>
export default {
    data(){
        return {
            message : "Hello world"
        }
    },
    mounted() {
        console.log('Example component mounted.')
    }
}
</script>
