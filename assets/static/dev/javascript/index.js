const tabular = {
  template: '<div>Tabular</div>'
}

const visual = {
  template: '<div>Visual</div>'
}

const root = {
  template: '<div>Input</div>'
}

const router = new VueRouter({
  routes: [
    {
      path: '/',
      component: root,
      children: [
        {
          path: 'tabular',
          component: tabular
        },
        {
          path: 'visual',
          component: visual
        }
      ]
    }
  ]
});

const app = new Vue({
  router
}).$mount('#app')
