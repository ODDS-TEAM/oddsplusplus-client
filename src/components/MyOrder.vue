<template>
  <div>
    <div class="header">
      <h1 style="text-align:center;padding:0;">My orders</h1>
    </div>
    <ul>
      <li v-for="item in data" v-bind:key="item.value">
        <div class="card">
          <div class="row">
            <div class="col-2">
              <p>
                <img id="card-boot-image" class="img-item" :src="item.imgUrl" />
              </p>
            </div>

            <div class="col-10">
              <div class="detail">
                <table style="height:90px;">
                  <tr>
                    <h3>{{ item.title }} ({{item.format}})</h3>
                  </tr>
                  <tr>
                    <h4>By {{ item.author }}</h4>
                    <h3 style="">Qty 5</h3>
                  </tr>
                </table>
                <table style="height:40px;" class="tb-btn">
                  <tr>
                    <td>
                      <p>
                        <button class="footer-btn main-color">Summary</button>
                      </p>
                    </td>
                    <td>
                      <p>
                        <button class="footer-btn" style="background-color: #f55246;">Delete</button>
                      </p>
                    </td>
                  </tr>
                </table>
              </div>
            </div>
          </div>
        </div>
      </li>
    </ul>
  </div>
</template>

<script>
export default {
  data() {
    return {
      data: null,
      user: null,
      orderdate: true
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
.header {
  margin-top: 50px;
  font-weight: 900;
}
.detail {
  text-align: left;
  padding: 0 25px;
}
table {
  border-spacing: 0;
}
.tb-btn {
  width: 100%;
  margin: 10px auto;
}
tr {
  width: 100px;
}
p {
  text-align: center;
}
.img-item {
  position: relative;
  margin: auto auto;
  max-width: 110px;
  max-height: 168.4px;
}
.card {
  border-radius: 10px;
  box-shadow: 0 0 15px 0 rgba(0, 0, 0, 0.2);
  transition: 0.3s;
  width: 80%;
  margin: 25px auto;
}
.card:hover {
  box-shadow: 0 0 15px 0 rgba(0, 0, 0, 0.5);
}

.footer-btn {
  border: 0;
  color: white;
  width: 90px;
  height: 30px;
  border-radius: 4px;
  margin: auto 5px;
}

@media only screen and (min-width: 768px) {
  p {
    margin: 0;
    padding: 0;
    text-align: left;
  }
  ul {
    margin-top: 10px;
  }
  .card {
    width: 500px;
    height: 140px;
  }
  .footer-btn {
    margin: auto 15px 10px 0;
  }

  .img-item {
    position: relative;
    margin: auto auto;
    max-width: 100px;
    max-height: 140px;
    border-radius: 10px 0 0 10px;
  }
  .tb-btn {
    width: 50%;
    float: right;
    margin: -20px 0;

  }
  .header {
    margin-top: 100px;
  }
}
</style>
