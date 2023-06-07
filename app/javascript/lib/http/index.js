import axios from 'axios';

const root = axios.create({
  baseURL: `${window.location.origin}/${window.gon.config.market}/`
  headers: {
    'X-Requested-With': 'XMLHttpRequest',
    'Access-Control-Allow-Origin': '*',
    'Access-Control-Allow-Credentials': true,
    'Access-Control-Allow-Methods': 'GET, POST',
    'Accept': 'application/json, text/javascript, */*; q=0.01',
    'Content-Type': 'application/json; charset=UTF-8'
//    Authorization: ''
  }
})

const objToQueryString = function(params) {
  let dataPairs = [];
  for(name in params){ 
    if(typeof(params[name]) == 'object'){
      dataPairs.push(encodeURIComponent(name) + '=' + objToQueryString(params[name])) 
    }
    else{
      dataPairs.push(encodeURIComponent(name) + '=' + encodeURIComponent(params[name])) 
    }
    
  }
  return dataPairs.join('&').replace(/%20/g, '+');
}

// IE not support
// export const objToQueryString = (data = {}) => {
//   const params = new URLSearchParams();
//   Object.entries(data).forEach(([key, value]) => {
//     params.append(key, value);
//   });
//   return params.toString();
// };

export {
  root,
  objToQueryString
}
