Note that to work with the vertex color shader, the following change was made to<br>
./Assets/UTJ/Alembic/Editor/Importer

```
public Material defaultMaterial
{
    get
    {
        if (m_defaultMaterial == null)
        {
            m_defaultMaterial = (Material) AssetDatabase.LoadAssetAtPath("Assets/Materials/NewAlembic_mtl.mat", typeof(Material)); //new Material(Shader.Find("Alembic/Standard"));
            //m_defaultMaterial.hideFlags = HideFlags.NotEditable;
            //m_defaultMaterial.name = "Default Material";
            //Add("Default Material", m_defaultMaterial);
        }
        return m_defaultMaterial;
    }
}
```