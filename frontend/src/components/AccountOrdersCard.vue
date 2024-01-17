<template>
  <q-card class="bg-white q-my-lg" style="box-shadow: none; border-radius: 25px; height: 130px;">
    <q-card-section class="bg-grey-1 q-pa-sm" style="border: 1px solid #bebdbd">
      <div class="row">
        <div class="bg-brown-2 q-pa-sm q-ma-xs" style="border-radius: 20px; width: 120px">
         <div v-if="props.photo[0]" style="margin: 10px ;width: 122px; height: 110px; overflow: hidden; border-radius: 20px; position: absolute; top: 0; left: 0;">
          <v-lazy-image :src="props.photo[0]" alt="Avatar" style="width: 100%; height: 100%; object-fit: cover;"
          :src-placeholder="props.photo[1]"/>
        </div>
          <q-icon v-else size="100px" color="dark" name="mood"  />
        </div>
        <div>
          <div class="text-weight-bold q-ml-md q-mt-sm q-mb-sm text-dark" style="font-size: 17px;">{{ props.status }}</div>
          <div class="q-ml-md" style="font-size: 12px; margin-top: 26px"> {{ props.name }}<br> Цвет: {{ props.color.name }}<br> Размер: {{ props.size.name }}</div>
        </div>
      </div>
    </q-card-section>
  </q-card>
</template>

<style>
.v-lazy-image {
  filter: blur(10px);
  transition: filter 0.7s;
}

.v-lazy-image-loaded {
  filter: blur(0);
}
</style>

<script setup>
import VLazyImage from "v-lazy-image";

const props = defineProps({
  name: String,
  size: Array,
  status: String,
  color: Array,
  photo: Array,
  id: Number
})
</script>
