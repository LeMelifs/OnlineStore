<template>
  <div style="width: 20%; height: 300px; " class="q-mx-sm q-px-sm">
    <router-link :to="{ name: 'Product', params: { id: props.id }}">
      <div class="bg-brown-2 q-mx-md q-mr-sm q-paxl parent" style="border-radius: 15px; position: relative; width: 260px; height: 260px;">
        <div v-if="props.photo[0]" style="width: 100%; height: 100%; overflow: hidden; border-radius: 15px; position: absolute; top: 0; left: 0;">
          <v-lazy-image :src="props.photo[0]" alt="Avatar" style="width: 100%; height: 100%; object-fit: cover;"
          :src-placeholder="props.photo[1]"/>
        </div>
        <q-icon v-else style="margin-top: 40px" size="180px" color="dark" name="mood" />
      </div>
    </router-link>
    <router-link to="/product">
      <div class="text-weight-bold text-grey-10 text-h6 q-mt-md" style="margin-left: 21px">
        {{ props.name }}
      </div>
    </router-link>
    <div class="text-grey-6  q-mt-xs" style="margin-left: 21px">
      {{ props.description }}
    </div>
    <div class="text-weight-bold text-grey-10 text-h6 q-mt-xs" style="margin-left: 21px">
      {{ props.price }}
    </div>
  </div>
</template>

<style>
.parent {
  display: flex;
  justify-content: center;
}
a {
  color: transparent;
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

import VLazyImage from "v-lazy-image";

const props = defineProps({
    id: Number,
    name: String,
    price: Number,
    description: String,
    category_id: Number,
    photo: Array
})

</script>
