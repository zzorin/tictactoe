<template>
  <div class="participant-form background-gray with-paddings mb-4">
    <form>
      <div class="form-group">
        <div class="row">
          <div class="col">
            <b><label>Размер поля</label><span class="necessary-field text-danger">*</span></b>
            <!-- <input type="text" v-model='game.size' class="form-control" /> -->
          </div>
        </div>
      </div>
    </form>
  </div>
</template>

<script>
  import { mapState, mapMutations, mapActions, mapGetters } from 'vuex'
  import { CommonMixin } from 'mixins/common'
  export default {
    mixins: [CommonMixin],
  }
</script>
