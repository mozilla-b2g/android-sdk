/*
 * Copyright (C) 2011 The Android Open Source Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.android.ide.eclipse.gltrace.views;

import com.android.ide.eclipse.gltrace.state.GLListProperty;
import com.android.ide.eclipse.gltrace.state.IGLProperty;

import org.eclipse.jface.viewers.ITableLabelProvider;
import org.eclipse.jface.viewers.LabelProvider;
import org.eclipse.swt.graphics.Image;

public class GLStateLabelProvider extends LabelProvider implements ITableLabelProvider {
    public Image getColumnImage(Object element, int columnIndex) {
        return null;
    }

    public String getColumnText(Object element, int columnIndex) {
        if (!(element instanceof IGLProperty)) {
            return "";
        }

        switch (columnIndex) {
            case 0:
                return getName((IGLProperty) element);
            case 1:
                return getValue((IGLProperty) element);
            default:
                return "";
        }
    }

    private String getValue(IGLProperty element) {
        return element.getStringValue();
    }

    private String getName(IGLProperty element) {
        IGLProperty parent = element.getParent();
        if (parent instanceof GLListProperty) {
            // For members of list, use the index in the list as the name as opposed to
            // the property type
            return Integer.toString(((GLListProperty) parent).indexOf(element));
        }

        return element.getType().toString();
    }
}
