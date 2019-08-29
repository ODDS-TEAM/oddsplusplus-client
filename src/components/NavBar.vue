<template>
    <div>
        <div class="nav">
            <router-link to=/home>
                <img class="user-img" src="./../assets/odds_logo.png" id="navbar-logo" />
            </router-link>
            <div>
                <table @click="menuDropShow = !menuDropShow" class="account-bar-m">
                    <tr>
                        <td><img class="img-pro" :src="user.imgURL" id="navbar-logo" /></td>
                        <td style="font-size: 15px;margin:0">
                            <h3 class="f-name">{{user.name}}
                            </h3>
                        </td>
                        <td><img class="arrow" src="./../assets/drop-down-arrow.png" id="navbar-dropdown" /></td>
                    </tr>
                </table>
                <div class="menu" v-if="menuDropShow">
                    <div class="menu-wrapper" @click="menuDropShow =false">
                        <div class="menu-container" @click.stop>
                            <h4 class="menu-list" id="navbar-list-home" @click="routing(0)">Home</h4>
                            <h4 class="menu-list" id="navbar-list-item" @click="routing(1)">Your Items </h4>
                            <h4 class="menu-list" id="navbar-list-order" @click="routing(2)">Your Orders </h4>
                            <h4 class="menu-list" id="navbar-list-signout" style="border-bottom:none;margin-bottom:0;" v-on:click="signOut">Sign Out</h4>
                        </div>
                    </div>
                </div>
    
            </div>
            <div class="main-color add-btn" v-on:click="showModal = true" id="navbar-add-button">
                <p style="padding:0;"><img class="ico-add-item" src="./../assets/add.png" id="navbar-logo" /></p>
            </div>
            <table class="account-bar-d" id="navbar-account-bar" @click="menuDropShow =true">
                <tr>
                    <td><img class="img-pro" style="margin:3px 5px; " :src="user.imgURL" id="navbar-logo" /></td>
                    <td style="font-size: 15px;margin:0; padding:0;">
                        <h3 class="f-name" style="margin-bottom: 3px;">{{user.name}}
                        </h3>
                    </td>
                    <td><img class="arrow" src="./../assets/drop-down-arrow.png" id="navbar-dropdown" /></td>
                </tr>
            </table>
        </div>
        <AddItemModal v-if="showModal" @close="showModal =false" @refresh="$emit('refreshMyItem')" />
    </div>
</template>

<script>
import AddItemModal from './modal/AddItemModal.vue'
export default {
    components: {
        AddItemModal
    },
    data() {
        return {
            renderComponent: true,
            responses: null,
            showModal: false,
            orderList: null,
            results: null,
            user: {
                id: null,
                name: null,
                email: null,
                imgURL: null,
            },
            orderModal: false,

            menuDropShow: false
        };
    },
    mounted: function() {
        this.user.id = localStorage.getItem("userId");
        this.user.name = localStorage.getItem("name");
        this.user.email = localStorage.getItem("email");
        this.user.imgURL = localStorage.getItem("imgURL");
    },
    methods: {
        refreshNav() {
            this.renderComponent = false;
            this.$nextTick(() => {
                window.console.log('nav');
                this.renderComponent = true;
            });
        },
        closeDropSHow() {
            if (this.menuDropShow)
                this.menuDropShow = false;

        },
        closeModal() {
            this.$emit('refreshMyItem');
            this.$nextTick(() => {
                this.showModal = false;
            })
        },
        routing(page) {
            this.menuDropShow = false;
            const menu = ['/home','/myitem','/myorder']
            this.$router.push(menu[page]);
        },
        signOut() {
            // localStorage.clear();
            window.location.href = 'https://www.google.com/accounts/Logout';
            window.location.href = 'https://api-dev.odds.team/logout';
            this.$router.push('/');
        }


    }
}
</script>

<style scoped>
* {
    box-sizing: border-box;
}

.account-bar-d {
    float: right;
    margin-right: 10px;
    height: 50px;
    display: none;
}

.l-name,
.f-name {
    margin: 0;
}

.l-name {
    display: none;
}

.menu {
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

.ico-add-item {
    margin: 7px auto;
    width: 18px;
    height: 18px;
}

.menu-wrapper {
    display: table-cell;
    vertical-align: middle;
}

.menu-container {
    position: fixed;
    transform: translate(50%, 0);
    top: 60px;
    right: 50%;
    background-color: #eeeeee;
    width: 170px;
    border-radius: 7px
}

.img-pro {
    width: 40px;
    height: 40px;
    display: none;
}

.menu-list {
    padding: 12px 25px;
    text-decoration: none;
    display: block;
    border-radius: 7px;
    text-align: left;
    font-size: 15px;
}

.menu-list:hover {
    background-color: #c5c5c5;
}

.user-img {
    position: fixed;
    transform: translate(0, -50%);
    top: 20px;
    left: 10px;
    width: 80px;
    height: auto;
}

.arrow {
    margin-top: 9px;
    width: 11px;
    height: auto;
}

.account-bar-m {
    position: fixed;
    transform: translate(-50%, -50%);
    top: 21.5px;
    left: 50%;
    color: #333;
    background-color: #f1f1f1;
    cursor: pointer;
    transition: 0.2s;
}

.account-bar-m:hover {
    padding: 0 5px;
    border-radius: 5px;
    background-color: #dfdfdf;
}

p {
    font-size: 12px;
    line-height: 20px;
    color: #727272;
    padding: 10px 0;
    margin: 0;
    text-align: center;
}

.nav {
    position: fixed;
    /* Set the navbar to fixed position */
    top: 0;
    /* Position the navbar at the top of the page */
    width: 100%;
    margin: 0;
    padding: 6px 10px;
    overflow: hidden;
    background-color: #f1f1f1;
    height: 43px;
    border-bottom: 2px solid #efefef;
    box-shadow: 0 0 5px -1px rgba(0, 0, 0, 0.5);
    z-index: 2;
}

img {
    margin: 2px 0;
    height: 27px;
}

.add-btn {
    float: right;
    width: 40px;
    height: 31px;
    font-size: 23px;
    border-radius: 5px;
    cursor: pointer;
    margin-left: 10px;
    padding: 0;
}

.add-btn>p {
    text-align: center;
    padding: 7px 0;
    font-size: 35px;
    color: white;
    font-weight: 800;
    font-family: "Roboto", sans-serif;
}

h5 {
    margin: 0;
}

@media only screen and (min-width: 600px) {
    .account-bar-d {
        height: 52px;
        display: block;
    }
    .account-bar-d:hover {
        cursor: pointer;
        padding: 0 0 5px;
        border-radius: 5px;
        background-color: #dfdfdf;
    }
    .user-img {
        width: auto;
        height: 30px;
        top: 24px;
    }
    .l-name {
        display: inline-block;
    }
    .menu-container {
        top: 80px;
        right: 140px;
        border-radius: 7px
    }
    .nav {
        height: 64px;
    }
    img {
        margin: 7px 0;
        height: 40px;
    }
    .add-btn {
        width: 53px;
        height: 50px;
        font-size: 35px;
    }
    .add-btn>p {
        padding: 15px 0;
    }
    p {
        font-size: 12px;
        line-height: 20px;
        color: #727272;
        padding: 20px 0;
        margin: 0;
    }
    .account-bar-m {
        display: none;
    }
    .img-pro {
        display: inline;
        border-radius: 5px;
        margin: 5px 5px 0 5px;
    }
    .ico-add-item {
        margin: 12px auto;
        width: 27px;
        height: 27px;
    }
}
</style>

