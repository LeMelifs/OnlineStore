<template>
  <div class="q-py-md q-mr-md" style="width: 640px; border-radius: 25px; margin-left: 180px">
    <div class="row">
      <div class="bg-brown-2 q-my-md q-mr-md q-pa-md parent" style="width: 180px; border-radius: 15px">
        <div v-if="props.photo[0]" style="width: 120px; height: 120px; overflow: hidden; border-radius: 20px; position: relative;">
          <v-lazy-image :src="props.photo[0]" alt="Avatar" style="width: 100%; height: 100%; object-fit: cover;
           position: absolute; top: 0; left: 0;" :src-placeholder="props.photo[1]"/>
        </div>
        <q-icon v-else size="180px" color="dark" name="mood" />
      </div>
      <div class="q-ma-md">
        <div style="font-weight: bold; font-size: 20px">{{ props.name }}</div>
        <div class="text-grey-8">Размер: {{ props.size }}</div>
        <div class="text-grey-8">Цвет: {{ props.color }}</div>
        <div style="font-weight: bold; margin-top: 80px; padding-top: 18px; font-size: 22px">{{ props.price }} ₽</div>
      </div>
      <div class="q-ma-md column" style="display: flex; justify-content: space-between; align-items: flex-start">
        <div class="round" style="margin-left: 100px">
          <input type="checkbox" checked :id="props.id" v-model="isChecked"  />
          <label :for="props.id">
            <div class="checkmark" v-if="isChecked"></div>
          </label>
        </div>
        <q-btn flat round dence style="margin-left: 75px; margin-bottom: 5px">
          <q-icon  size="32px" color="dark" name="delete" />
        </q-btn>
<!--        <div style="font-weight: bold; font-size: 22px; color: #2f2f2f;">-->
<!--          <q-btn round outline style="font-size: 12px" color="grey-8" @click="decrement"><q-icon color="dark" name="remove"></q-icon></q-btn>-->
<!--          <span class="q-ma-md dark" style="font-size: 22px">{{ number }}</span>-->
<!--          <q-btn round outline style="font-size: 12px" color="grey-8" @click="increment"><q-icon color="dark" name="add"></q-icon></q-btn>-->
<!--        </div>-->
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

.v-lazy-image {
  filter: blur(10px);
  transition: filter 0.7s;
}
.v-lazy-image-loaded {
  filter: blur(0);
}
</style>

<script setup>
import {onMounted, onUnmounted, onUpdated, ref, watch} from "vue";
import store from "src/store";
import VLazyImage from "v-lazy-image";

let isChecked = ref(false)

const props = defineProps({
  id: Number,
  name: String,
  size: String,
  color: String,
  photo: Array,
  price: Number,
  status: Boolean
})

watch(() => props.status, () => {
    isChecked.value = props.status
})

onMounted(async () => {
  await store.dispatch('setOrder', [])
})

onUpdated(async () => {
  if (isChecked.value) {
    store.state.order.push({ id: props.id, name: props.name, size: props.size, color: props.color, photo: props.photo,
    price: props.price, status: props.status })
    await store.dispatch('setOrder', store.state.order)
  }
  else {
      let lists = store.state.order.filter(x => {
      return x.id !== props.id;
    })
    await store.dispatch('setOrder', lists)
  }
})
</script>

<script>
export default {
  data() {
    return {
      number: 1,
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
};
</script>
