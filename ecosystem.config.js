module.exports = {
  apps: [{
    name: 'bicrypto-v5',
    script: 'pnpm',
    args: 'start',
    cwd: '/var/www/bicrypto571',
    instances: 1,
    autorestart: true,
    watch: false,
    max_memory_restart: '1G',
    env: {
      NODE_ENV: 'production'
    }
  }]
};
