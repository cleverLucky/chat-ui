extends Node

# 预加载猫猫背景图
@export var background_texture: Texture2D = preload("res://assets/miao.png")

func _ready() -> void:
    var bg_image = TextureRect.new()
    bg_image.texture = background_texture
    bg_image.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED  # 保持比例并居中
    bg_image.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
    
    # 设置大小
    var target_width = 800.0
    var scale = target_width / background_texture.get_width()
    var target_height = background_texture.get_height() * scale
    bg_image.size = Vector2(target_width, target_height)
    
    # 添加到场景中
    add_child(bg_image)
    
    # 等待一帧确保节点在场景树中
    await get_tree().process_frame
    
    # 现在可以安全地获取视口并居中
    var viewport_size = get_viewport().get_visible_rect().size
    bg_image.position = (viewport_size - bg_image.size) / 2
    
    bg_image.z_index = -10
    
    print("猫猫背景加载成功！图片已缩小并居中 😺")

func _process(_delta: float) -> void:
    if Input.is_key_pressed(KEY_ESCAPE):
        get_tree().quit()