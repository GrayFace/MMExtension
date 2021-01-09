Blv, Dlv, Odm, Ddm
---

For example, to edit an MM6 outdoor map do this:

- Open extracted ODM using MM6odm template.

- Open extracted DDM right after using MMddm template. Information extracted from last loaded ODM will be used to read it.


Evt
---

Open file with MM6blv, MM7blv or MM8blv accordingly.

To make things easier, create a new file and copy-paste Reference description into it (set "Edit As" to "Text" if it appears in hex). You will use this reference whenever you need to add a new instruction.

When editing hex representation of an instruction in Template Results window, you can replace it with one of the following actions:

- ` `(space) or an empty string:  Remove instruction.

- `-`:  Remove instruction, shift instruction numbers after it by -1.

- `+0A`:  Add instruction "0A" after this one (use any inscturion number instead of "0A").

- `*0A`:  Add instruction "0A" after this one, shift instruction numbers after it by +1 (use any inscturion number instead of "0A").
