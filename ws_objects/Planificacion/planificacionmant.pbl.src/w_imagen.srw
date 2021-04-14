$PBExportHeader$w_imagen.srw
forward
global type w_imagen from window
end type
type p_imagen from picture within w_imagen
end type
end forward

global type w_imagen from window
integer x = 1198
integer y = 884
integer width = 1362
integer height = 856
boolean titlebar = true
string title = "Imagen"
boolean controlmenu = true
windowtype windowtype = popup!
long backcolor = 79741120
p_imagen p_imagen
end type
global w_imagen w_imagen

on w_imagen.create
this.p_imagen=create p_imagen
this.Control[]={this.p_imagen}
end on

on w_imagen.destroy
destroy(this.p_imagen)
end on

event open;string ref_lab, v_articulo, codigo_pantallas
Datawindow DW
DW = Message.PowerObjectParm

v_articulo = DW.object.cod_articulo[DW.GetRow()]

select referencia_laboratorio, codigo_pantallas
into :ref_lab, :codigo_pantallas
from articulos
where empresa = :codigo_empresa
and codigo = :v_articulo;

w_imagen.p_imagen.PictureName = f_cargar_imagen_nuevo(codigo_pantallas)



end event

event key;if Key = KeyEscape! then
	close(This)
end if 
end event

type p_imagen from picture within w_imagen
integer x = 46
integer y = 36
integer width = 1257
integer height = 696
boolean originalsize = true
boolean focusrectangle = false
end type

