import axios from "axios";

export default axios.create({
    baseURL: "https://sutplan.com/",
    headers: {
        'Access-Control-Allow-Origin': '*',
        "Content-type": "application/json",
    }
});