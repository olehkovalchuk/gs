<template lang="pug">
  b-modal(
    :title="hasFields ? translate('common.add_required_info') : translate('common.confirm_the_step_is_completed')"
    id="step-popup"
    centered
    dialog-class="popup-default popup-default--small"
    content-class="popup-default--content datepicker-popup"
    header-class="popup-default--header"
    body-class="popup-default--body"
    hide-footer
    ref="modal"
    )
    form.bid-form(@submit.prevent="submit")
      .form_row(v-for="item in step.required_fields")
        template(v-if="'string' == item.field_type")
          label.form-label {{item.title}} *
          input.txtinput(
            type="text"
            v-model="fieldsToSend[item.id]"
            :name="getFieldName(item)"
            v-validate="'required'"
            :class="{ 'error': submited && errors.has(getFieldName(item)) }"
            )
          span.error-msg(v-show="errors.has(getFieldName(item))") {{translate("common.you_need_to_load_documents")}}
        template(v-if="'date' == item.field_type")
          .datepicker-block
            date-picker(
              v-model="fieldsToSend[item.id]"
              valueType="format"
              lang="en"
              :first-day-of-week="1"
              v-validate="'required'"
              :class="{ 'error': submited && errors.has(getFieldName(item)) }"
              :date-picker-options="datePickerOptions"
              )
        template(v-if="'file' == item.field_type")
          .not-loaded
            input.hidden( :name="getFieldName(item)" type="file" :id="'load-file-' + item.id"  @change="onFileChange($event, item)")
            label.attachment--item(:for="'load-file-' + item.id")
              svg-icon(name="icon-clip" class="mr-2")
              | {{item.title}}
          span.error-msg(v-show="errors.has(getFieldName(item))") {{translate("common.you_need_to_load_documents")}}
      .btn-block
        input.btn(type="submit" @click.prevent="submit()" :value="translate('common.save')")
</template>

<script>
import DatePicker from 'vue2-datepicker'
export default {
  components:{
    DatePicker
  },
  computed:{
    step(){
      return this.$store.getters['processes/getCurrentStep'];
    },
    hasFields(){
      return this.step.required_fields && this.step.required_fields.length > 0
    }
  },
  methods:{
    getFieldName(item){
      return 'field_' + item.field_type + '_' + item.id;
    },
    getItem(){
      return {item:{fields: this.fieldsToSend}, id: this.step.process_id, step: this.step.id }
    },
    onFileChange(e, item ){
      this.fieldsToSend[item.id] = (e.target.files || e.dataTransfer.files)[0]
      this.errors.remove(this.getFieldName(item))
    },
    resetForm(){
      // this.fields = {}
    },
    async validateForm(){
      const toValidate = []
      console.log(this.fieldsToSend)
      console.log(this.step.required_fields)
      for (let i in this.step.required_fields) {
        let id = String(this.step.required_fields[i].id)
        if(!this.fieldsToSend[id]){
          toValidate.push( this.$validator.validate( this.getFieldName(this.step.required_fields[i]) ) )
        }

      }
      const results = Promise.all([...toValidate]);
      return (await results).every(isValid => isValid);
    },
    submit (e) {
      this.submited = true;
      this.validateForm().then((result) => {
        if(result){
          this.$isLoading('isLoading', 'item_saved');
          this.$store.dispatch('processes/CompleteStep', this.getItem()).then(response => {
            if(response.success){
              this.$bvModal.hide("step-popup")
              this.$store.dispatch('marketplace/Success', this.translate("common.success_saved") )
              this.$isLoading('isLoading', 'item');
              this.$store.dispatch('processes/Show', response.id);
            }
            else{
              this.$store.dispatch('marketplace/Failure',response.message)
            }
          })
        }
      })

    }
  },
  data() {
    return {
      fieldsToSend:{},
      submited: false,
      date: '',
      datePickerOptions: {}
    }
  },
  mounted(){
    this.$root.$on('bv::modal::show', (bvEvent, modalId) => {
      if(modalId == "step-popup"){
        // this.resetForm()
      }
    })


  },
  "watch":{
    step(val){
      if(val.required_fields){
        for (let id in this.step.required_fields) {
          this.$validator.attach({ name:  this.getFieldName(this.step.required_fields[id]), rules: "required" });
        }
      }
    }
  }
}

</script>

<style lang="scss" scoped>
.hidden{
  display: none;
}
</style>
