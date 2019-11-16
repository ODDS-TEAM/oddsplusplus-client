import axios from 'axios'
const app  = axios.create({
    baseURL : process.env.VUE_APP_API,
    headers : {
        Authorization: { toString(){return sessionStorage.getItem('token')}}
    }
})
export function parseJwt (token) {
    var base64Url = token.split('.')[1];
    var base64 = base64Url.replace(/-/g, '+').replace(/_/g, '/');
    var jsonPayload = decodeURIComponent(atob(base64).split('').map(function(c) {
        return '%' + ('00' + c.charCodeAt(0).toString(16)).slice(-2);
    }).join(''));

    return JSON.parse(jsonPayload);
}
export function Login(gooleToken) {
    return app.post("/login",{ token : gooleToken})
}

export function Register(userdata) {
    return app.patch("/register", userdata )
}

export function Scrap(bookUrl){
    return app.post("/responseScrap",bookUrl)
}

export function AddItem(item){
    return app.post("/additem",item)
}

export function getUser(uid) {
    return app.get("/user/"+uid)
}

export function getBooks () {
    return app.get("/items")
}

export function Reserve(itemId) {
    return app.get("/getreservesbyitem/"+ itemId)
}
// e.GET("/reserves/users/:userId/:itemId", a.GetOrderCount)

export function GetOrder(userId, itemId) {
    return app.get("/reserves/users/" + userId + "/" + itemId)
}

///current
export function DeleteOrderByUserAndItem(userId, itemId) {
    return app.delete("/reserves/" + userId + "/" + itemId)
}
export function AddReserve(userId, itemId, count) {
    return app.post("/reserves/" + userId + "/" + itemId + "/" + count) 
}

export function UpdateOrder(itemId, totalPrice, charge) {
    return app.patch("/updateOrder/" + itemId + "/" + totalPrice + "/" + charge)
}

export function GetReserveByItemId(itemId) {
    return app.get("/getreserve/" + itemId)
}

export function GetItemUser(userId) {
    return app.get("/items/users/" + userId)
}

export function Order(userId, itemId, count) {
    return app.post("/order/" + userId + "/" + itemId + "/" + count)
}

export function GetReserveUser(userId) {
    return app.get("/reserves/users/" + userId)
}

export function DeleteReserveById(reserveId, userId) {
    return app.delete("/deletereserves/" + reserveId + "/" + userId)
}

export function GetSummary(itemId) {
    return app.get("/reserves/sum/" + itemId)
}

export function DeleteItemByItemIdAndUserId(userId, itemId) {
    return app.delete("/items/users/" + userId + "/" + itemId)
} 