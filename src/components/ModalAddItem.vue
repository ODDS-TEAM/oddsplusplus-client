<template>
    <div>
        <div class="modal">
            <input type="text"  placeholder="Please fill amazon book URL">
        </div>

    </div>
</template>
<script>
    export default {
       methods : {
           postItemURL(){

           }
       }
    }
</script>
<style scoped>
    .modal {
        border-radius: 20px;
        box-shadow: 0px 0px 49px 4px rgba(0,0,0,0.75);
        background-color: #333333;
        width: 400px;
        position: fixed;
        transform: translate(-50%, -50%);
        top: 50%;
        left: 50%;
        padding: 30px;
        z-index: 1;
    }

    input {
        margin: auto auto;
        width: 100%;
    }
</style>
