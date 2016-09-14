module.exports = function(grunt) {
  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),

    auto_spacing: {
      dist: {
        src: ['testText.html'],
        dest: 'dist/testText.html'
      }
    }
  });
  grunt.loadNpmTasks('grunt-auto-spacing');

  grunt.registerTask('default', ['auto_spacing']);

};