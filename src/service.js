import axios from 'axios'
const app  = axios.create({
    baseURL : process.env.VUE_APP_API,
    headers : {
        Authorization: sessionStorage.getItem('token')
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
    return app.patch("/register", userdata , {
        headers: { Authorization: sessionStorage.getItem("token") }
    })
}

export function getUser(uid) {
    return app.get("/user/"+uid)
}