import os
import json
import glob
import numpy as np
import turicreate as tc

# dataset directory
filepath = '/Users/alejandro.aliaga/Workspace/github/CoreML/Models/draw-recognition/dataset'
random_state = np.random.RandomState(1000)
num_examples_per_class = 1000

def build_strokes_sframe():      
    strokes, drawings_list, labels_list = [], [], []
    # Current Directory
    os.chdir(os.path.join(filepath, 'strokes'))

    for file in glob.glob('*.ndjson'):        
        class_name = file.split(".")[0].split("_").pop()
        print(class_name)

        with open(file) as fin:
            ndjson_data = list(map(lambda x: x.strip(), fin.readlines()))    

        random_state.shuffle(ndjson_data)
        ndjson_data_selected = list(map(json.loads, ndjson_data[:num_examples_per_class]))
        raw_drawing_list = [ndjson["drawing"] for ndjson in ndjson_data_selected]

        def raw_to_final(raw_drawing):
            return [
                [
                    {
                        "x": raw_drawing[stroke_id][0][i],
                        "y": raw_drawing[stroke_id][1][i]
                    } for i in range(len(raw_drawing[stroke_id][0]))
                ]
                for stroke_id in range(len(raw_drawing))
            ]

        final_drawing_list = list(map(raw_to_final, raw_drawing_list))
        drawings_list.extend(final_drawing_list)
        labels_list.extend([class_name] * num_examples_per_class)

        sf = tc.SFrame({"drawing": drawings_list, "label": labels_list})
        sf.save(os.path.join(filepath, f"strokes/stroke_{class_name}.sframe"))
        strokes.append(sf)

    return strokes    

sf_list = build_strokes_sframe()
for sf in sf_list:
    sf["renderer"] = tc.drawing_classifier.util.draw_strokes(sf["drawing"])
    sf.explore()