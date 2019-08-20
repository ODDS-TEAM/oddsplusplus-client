<template>
  <div>
    <ul>
      <li v-for="item in data" v-bind:key="item.value">
        <div class="card">
          <!-- <div class="row">
            <div class="col-2">
              <p style="margin:0;">
                <img id="card-boot-image" class="img-item" :src="item.imgUrl" />
              </p>
            </div>
              <h3 id="card-book-title" style="float:left;">{{ item.title }}</h3>
              <h4 id="card-book-author">{{item.format}}</h4>
          </div>-->
          <table style="height:100px;">
            <tr>
              <td>
                <img id="card-boot-image" class="img-item" :src="item.imgUrl" />
              </td>
              <td>
                <h3 id="card-book-title" style="float:left;">{{ item.title }}</h3>
                <h4 id="card-book-author">{{item.format}}</h4>
              </td>
              <td></td>
            </tr>
          </table>
        </div>
      </li>
    </ul>
  </div>
</template>

<script>
export default {
  data() {
    return {
      data: null
    };
  },
  mounted: function() {
    this.$http.get(process.env.VUE_APP_API + "/items").then(response => {
      this.data = response.body;
      window.console.log(this.data);
    });
  }
};
</script>

<style scoped>
table,
td {
  padding: 0 !important;
  margin: 0;
  border-spacing: 0;
}
td{
    padding: 5px;
    vertical-align: top;
}
h3{
    margin-top:0; 
    margin-left: 5px;
}
ul {
  padding: 0;
}
.card {
  width: 90%;
  height: 100px;
  padding: 0;
}

.img-item {
  height: 100px;
  border-radius: 10px 0 0 10px;
}
@media only screen and (min-width: 768px) {
  .card {
    width: 480px;
    height: 150px;
  }
}
</style>