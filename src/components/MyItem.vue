<template>
  <div>
    <div class="header">
      <h1 style="text-align:center;padding:0;">Your Items</h1>
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
                    <h3 id="item.title"> {{ item.title }}</h3>
                  </tr>
                  <tr>
                    <h4 id="item.author-format">By {{ item.author }} ({{item.format}})</h4>
                    <h3 style="color:red" id="item.price" >${{item.price}}</h3>
                  </tr>
                </table>
                <table style="height:40px;" class="tb-btn">
                  <tr>
                    <td>
                      <p>
                        <router-link :to="{ name: 'summary', params: { id: item.id }}">
                          <button id = "myitem-summary" class="footer-btn main-color">Summary</button>
                        </router-link>
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
      userId: null,
      orderdate: true
    };
  },
  mounted: function() {
    this.userId = localStorage.getItem("userId");
    this.$http.get(process.env.VUE_APP_API + "/items/users/" + this.userId).then(response => {
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
  max-width: 230px;
  max-height: 240px;
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
  font-size: 12px;
}

@media only screen and (min-width: 768px) {
  h3 {
  white-space: nowrap;
  width: 370px;
  overflow: hidden;
  text-overflow: ellipsis;
}

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
    margin-left: 15px;
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
    margin: -20px 0;
    float: right;
  }
  .header {
    margin-top: 100px;
  }
}
</style>

