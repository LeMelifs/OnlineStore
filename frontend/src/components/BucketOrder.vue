<template>
  <div class="q-py-md q-mr-md" style="width: 640px; border-radius: 25px; margin-left: 180px">
    <div class="row">
      <div class="bg-brown-2 q-my-md q-mr-md q-pa-md parent" style="width: 180px; border-radius: 15px">
        <q-icon size="150px" color="dark" name="mood" />
      </div>
      <div class="q-ma-md">
        <div style="font-weight: bold; font-size: 20px">Название продукта</div>
        <div class="text-grey-8">Размер: XL</div>
        <div style="font-weight: bold; margin-top: 80px; padding-top: 18px; font-size: 22px">1 500 ₽</div>
      </div>
      <div class="q-ma-md column" style="display: flex; justify-content: space-between; align-items: flex-start">
        <div class="round" style="margin-left: 100px">
          <input type="checkbox" checked  :id="uniqueId" v-model="isChecked"  />
          <label :for="uniqueId">
            <div class="checkmark" v-if="isChecked"></div>
          </label>
        </div>
        <div style="font-weight: bold; font-size: 22px; color: #2f2f2f;">
          <q-btn round outline style="font-size: 12px" color="grey-8" @click="decrement"><q-icon color="dark" name="remove"></q-icon></q-btn>
          <span class="q-ma-md dark" style="font-size: 22px">{{ number }}</span>
          <q-btn round outline style="font-size: 12px" color="grey-8" @click="increment"><q-icon color="dark" name="add"></q-icon></q-btn>
        </div>
      </div>
    </div>
    <q-separator class="q-mt-md" style="width: 570px; margin-top: 25px"/>
  </div>
</template>

<style>
.parent {
  display: flex;
  justify-content: center;
}

.round {
  margin-right: 10px;
  padding: 15px 0;
  position: relative;
}

.round label {
  background-color: #fff;
  border: 1px solid #484848;
  border-radius: 50%;
  cursor: pointer;
  height: 30px;
  position: absolute;
  top: 0;
  right: 0;
  width: 30px;
}

.round label:after {
  border: 2px solid #484848;
  border-top: none;
  border-right: none;
  content: "";
  height: 9px;
  left: 7px;
  opacity: 0;
  position: absolute;
  top: 8px;
  transform: rotate(-45deg);
  width: 14px;
}

.round input[type="checkbox"] {
  visibility: hidden;
}

.round input[type="checkbox"]:checked + label {
  background-color: #ffffff;
  border-color: #3a3a3a;
}

.round input[type="checkbox"]:checked + label:after {
  opacity: 1;
}
</style>

<script>
export default {
  data() {
    return {
      number: 0,
      isChecked: false,
    };
  },
  methods: {
    increment() {
      this.number++;
    },
    decrement() {
      if (this.number > 0)
      this.number--;
    },
  },
  computed: {
    uniqueId() {
      return 'checkbox_' + Math.random().toString(36).substr(2, 9); // генерация уникального id
    },
  },
};
</script>
