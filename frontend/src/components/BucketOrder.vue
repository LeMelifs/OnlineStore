<template>
  <div class="q-py-md q-mr-md q-ma-lg " style="width: 640px; border-radius: 25px; margin-left: 140px">
    <div class="row">
      <div class="bg-brown-2 q-my-md q-mr-md q-pa-md parent" style="width: 180px; border-radius: 25px">
        <q-icon size="150px" color="dark" name="mood" />
      </div>
      <div class="q-ma-md">
        <div style="font-weight: bold; font-size: 20px">Название продукта</div>
        <div class="text-grey-8">Размер: XL</div>
        <div style="font-weight: bold;margin-top: 80px; padding-top: 18px; font-size: 22px">1 500 ₽</div>
      </div>
      <div class="q-ma-md" style="text-align: right; margin-left: 70px;">
        <div class="round">
          <input type="checkbox" checked id="checkbox" />
          <label for="checkbox"></label>
        </div>
        <div style="font-weight: bold;margin-top: 95px; font-size: 22px; color: #2f2f2f;">
          <q-btn round outline color="grey-8" @click="decrement"><q-icon color="dark" name="remove"></q-icon></q-btn>
          <span class="q-ma-md dark">{{ number }}</span>
          <q-btn round outline color="grey-8" @click="increment"><q-icon color="dark" name="add"></q-icon></q-btn>
        </div>
      </div>
    </div>
    <q-separator class="q-mt-lg"/>
  </div>
</template>

<style scoped>
.parent {
  display: flex;
  justify-content: center;
}
.round {
  margin-left: 88px;
  padding-bottom: 15px;
}

.round label {
  background-color: #fff;
  border: 1px solid #484848;
  border-radius: 50%;
  cursor: pointer;
  height: 40px;
  left: 0;
  position: absolute;
  top: 0;
  width: 40px;
}

.round label:after {
  border: 2px solid #484848;
  border-top: none;
  border-right: none;
  content: "";
  height: 10px;
  left: 11px;
  opacity: 0;
  position: absolute;
  top: 12px;
  transform: rotate(-45deg);
  width: 15px;
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
    };
  },
  methods: {
    increment() {
      this.number++;
    },
    decrement() {
      this.number--;
    },
  },
};
</script>
