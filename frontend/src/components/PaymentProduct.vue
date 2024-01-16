<template>
  <div class="q-py-md" style="width: 640px; border-radius: 25px;">
    <div class="row">
      <div class="bg-brown-2 q-my-md q-mr-md parent" style="width: 100px; border-radius: 15px; height: 100px; padding-top: 10px; position: relative">
        <div v-if="props.photo[0]" style="width: 100%; height: 100%; overflow: hidden; border-radius: 20px; position: absolute; top: 0; left: 0;">
            <img :src="props.photo[0]" alt="Avatar" style="width: 100%; height: 100%; object-fit: cover;">
          </div>
        <q-icon v-else style="margin-top: 40px" size="180px" color="dark" name="mood" />
      </div>
      <div class="q-ma-md">
        <div style="font-weight: bold; font-size: 17px">{{ props.name }}</div>
        <div class="text-grey-8" style="font-size: 13px">Размер: {{ props.size }}</div>
         <div class="text-grey-8" style="font-size: 13px">Цвет: {{ props.color }}</div>
        <div style="font-weight: bold;padding-top: 18px; font-size: 22px">{{ props.price }} ₽</div>
      </div>
    </div>
    <q-separator style="margin-bottom: -10px"/>
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

<script setup>
  const props = defineProps({
    id: Number,
    name: String,
    photo: Array,
    size: String,
    color: String,
    price: Number
  })
</script>
