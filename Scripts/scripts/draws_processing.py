import os
import glob
import turicreate as tc
import numpy as np

random_state = np.random.RandomState(1000)
filepath = '/Users/alejandro.aliaga/Workspace/github/CoreML/Models/draw-recognition/dataset'
num_examples_per_class = 1000

def build_bitmap_sframe():    
    sf_list, bitmap_list, labels_list = [], [], []
    os.chdir(filepath)

    for file in glob.glob('*.npy'):        
        class_name = file.split(".")[0].split("_").pop()
        print(class_name)

        class_data = np.load(f'{filepath}/{file}')
        
        random_state.shuffle(class_data)
        class_data_selected = class_data[:num_examples_per_class]
        class_data_selected = class_data_selected.reshape(
            class_data_selected.shape[0], 28, 28, 1
        )

        for np_pixel_data in class_data_selected:
            FORMAT_RAW = 2
            bitmap = tc.Image(_image_data = np_pixel_data.tobytes(),
                                _width = np_pixel_data.shape[1],
                                _height = np_pixel_data.shape[0],
                                _channel = np_pixel_data.shape[2],
                                _format_enum = FORMAT_RAW,
                                _image_data_size = np_pixel_data.size
                                )
            
            bitmap_list.append(bitmap)
            labels_list.append(class_name)

        sf = tc.SFrame({"drawing": bitmap_list, "label": labels_list})
        sf.save(os.path.join(filepath, f"sframes/{class_name}.sframe"))
        sf_list.append(sf)
    
    return sf

sf_list = build_bitmap_sframe()
