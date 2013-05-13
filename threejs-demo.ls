width = 400
height = 300
view-angle = 45
aspect = width / height
near = 0.1
far = 10000

$container = $ '#container'

renderer = new THREE.WebGLRenderer

camera = new THREE.PerspectiveCamera view-angle, aspect, near, far

scene = new THREE.Scene

camera.position.z = 300

renderer.set-size width, height

$container.append renderer.dom-element

sphere-material = new THREE.MeshLambertMaterial {color: 13369344}

radius = 50

segments = 16

rings = 16

sphere = new THREE.Mesh (new THREE.SphereGeometry radius, segments, rings), sphere-material

scene.add sphere

scene.add camera

pointLight = new THREE.PointLight 16777215

pointLight.position.x = 10

pointLight.position.y = 50

pointLight.position.z = 130

scene.add pointLight

renderer.render scene, camera
