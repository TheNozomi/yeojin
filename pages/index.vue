<script>
  export default {
    data() {
      return {
        images: [],
        currentImg: null
      }
    },
    methods: {
      setRandomImage () {
        if (!this.images?.length) return;
        this.currentImg = this.images[Math.floor(Math.random() * this.images.length)];
      }
    },
    async mounted () {
      const { data } = await fetch('https://www.reddit.com/r/Yeojin.json').then(res => res.json());
      data.children.forEach((item) => {
        if (item.data.link_flair_css_class === 'image') {
          this.images.push(item.data.url);
        }
      });
      this.setRandomImage();
    }
  }
</script>

<template>
  <v-row justify="center" align="center">
    <v-col cols="12" sm="8" md="6">
      <v-card>
        <v-card-title class="headline">
          YeoJin
        </v-card-title>
        <v-img
          class="white--text align-end"
          height="360px"
          contain
          :src="currentImg"
        />
        <v-card-actions>
          <v-spacer />
          <v-btn
            color="primary"
            @click="this.setRandomImage"
            nuxt
          >
            View another
          </v-btn>
        </v-card-actions>
      </v-card>
    </v-col>
  </v-row>
</template>
