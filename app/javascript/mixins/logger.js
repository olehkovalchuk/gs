const LOG_CODES = {
  SUCCESS: 1,
  ERROR: 2,
  EXCEPTION: 3,
  INFO: 4,
}

import Vue from "vue";

const logger = function(message,status) {
        fetch(`/log`, {
          method: 'post',
          body: JSON.stringify({
            description: message,
            status: status
          })
        }).then(function(result){
          console.log(result)
        })
      }

Vue.mixin({
  data: function() {
    return {
      logger: logger
    }
  }
})

export default {
    info: (args) => logger(info,LOG_CODES.INFO),
    success: (info) => logger(info,LOG_CODES.SUCCESS),
    error: (info) => logger(info,LOG_CODES.ERROR),
    exception: (info) => logger(info,LOG_CODES.EXCEPTION), 
}
