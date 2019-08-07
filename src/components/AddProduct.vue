<template>
    <div class="fab-wrapper"> <a class="fab-button"><h1 style="color: white;">+</h1></a> </div>
</template>

<script>
export default {
    
}
</script>

<style>
.fab-wrapper{
  position: fixed;
  right: 40px;
  top: 100px;
  z-index: 5;
  display: flex;
  flex-direction: center;
  align-items: center;
  
}

.fab-button{
  width: 70px;
  height: 70px;
  background-color: #FE7235;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  border-radius: 50%;
  box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.3);
  transition: all 0.1s ease-in-out;
}  
.fab-button:hover{
    transform: scale(1.25);
    box-shadow: 0px 4px 15px rgba(0, 0, 0, 0.3);
}

.fab-button p {
  font-size: 30px;
  color: #ffffff;
  text-align: center;
  line-height: 70px
}

</style>
