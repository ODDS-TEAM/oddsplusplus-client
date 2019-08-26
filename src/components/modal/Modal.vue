<template>
  <div>
    <div class="modal">
      <div class="wrapper" @click="$emit('close')">
        <div class="modal-container" @click.stop>
         <div class="modal-body">
           <slot name="body"/>
         </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  methods: {
    close() {
      this.$emit("close");
    }
  }
};
</script>

<style scoped>


.modal-container {
  border-radius: 10px;
  margin: 0px auto;
  padding: 5px 20px 5px;
  background-color: #fff;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.33);
  transition: all 0.3s ease;
  font-family: Helvetica, Arial, sans-serif;
  overflow-y:scroll;
  max-height: 95%;

}

.modal {
  position: fixed;
  z-index: 5;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-color: rgba(0, 0, 0, 0.5);
  display: table;
  transition: opacity 0.3s ease;
}

.wrapper {
  display: table-cell;
  vertical-align: middle;
}
@media only screen and (min-width: 768px) {
  .modal-container {
    width: 550px;
  }
}
</style>
