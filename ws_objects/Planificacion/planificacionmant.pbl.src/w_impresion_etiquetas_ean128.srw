$PBExportHeader$w_impresion_etiquetas_ean128.srw
forward
global type w_impresion_etiquetas_ean128 from window
end type
type st_4 from statictext within w_impresion_etiquetas_ean128
end type
type st_3 from statictext within w_impresion_etiquetas_ean128
end type
type st_2 from statictext within w_impresion_etiquetas_ean128
end type
type st_1 from statictext within w_impresion_etiquetas_ean128
end type
type st_articulo from statictext within w_impresion_etiquetas_ean128
end type
type em_calibre from u_em_campo within w_impresion_etiquetas_ean128
end type
type em_tono from u_em_campo within w_impresion_etiquetas_ean128
end type
type uo_calidad from u_em_campo_2 within w_impresion_etiquetas_ean128
end type
type uo_articulo from u_em_campo_2 within w_impresion_etiquetas_ean128
end type
type pb_imprimir from picturebutton within w_impresion_etiquetas_ean128
end type
type ddlb_tipo_etiqueta from dropdownlistbox within w_impresion_etiquetas_ean128
end type
type gb_1 from groupbox within w_impresion_etiquetas_ean128
end type
end forward

global type w_impresion_etiquetas_ean128 from window
integer width = 4910
integer height = 352
boolean titlebar = true
string title = "Impresión Etiquetas"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 12632256
string icon = "AppIcon!"
boolean center = true
st_4 st_4
st_3 st_3
st_2 st_2
st_1 st_1
st_articulo st_articulo
em_calibre em_calibre
em_tono em_tono
uo_calidad uo_calidad
uo_articulo uo_articulo
pb_imprimir pb_imprimir
ddlb_tipo_etiqueta ddlb_tipo_etiqueta
gb_1 gb_1
end type
global w_impresion_etiquetas_ean128 w_impresion_etiquetas_ean128

type variables
long il_ot
end variables

forward prototypes
public subroutine f_datos_ot ()
end prototypes

public subroutine f_datos_ot ();string ls_articulo,ls_calidad,ls_lote
int    li_calibre

select isnull(planificacion.cod_articulo,''),
		 isnull(planificacion.calidad,''),
		 isnull(planificacion.lote,''),
		 isnull(planificacion.calibre,0)
into   :ls_articulo,
		 :ls_calidad,
		 :ls_lote,
		 :li_calibre
from   planificacion
where  planificacion.empresa = :codigo_empresa
and    planificacion.ot      = :il_ot;

if trim(ls_calidad) = "" then ls_calidad = "1"

if trim(ls_lote) = "" then 
	select convert(varchar(20),isnull(articulos.ultimo_lote,0) +1)
	into   :ls_lote
	from   articulos
	where  articulos.empresa = :codigo_empresa
	and    articulos.codigo  = :ls_articulo;
	
	//Updatear la tabla articulos
	update articulos
	set    articulos.ultimo_lote = isnull(articulos.ultimo_lote,0) +1
	where  articulos.empresa = :codigo_empresa
	and    articulos.codigo  = :ls_articulo;	
	
	commit;
end if
	
//Gestion de calibre con calibre = 5	
if li_calibre = 0 and f_calibre_articulo(codigo_empresa,ls_articulo) = "S" then
	li_calibre = 5	
end if
	
uo_articulo.em_codigo.text = ls_articulo
uo_articulo.event modificado(0,0)
uo_calidad.em_codigo.text  = ls_calidad
uo_calidad.event modificado(0,0)
em_tono.text = ls_lote
em_calibre.text = string(li_calibre,em_calibre.mask)

//etiquetas del articulo
string ls_sel,ls_descripcion_etiqueta
long   ll_indice,ll_total

datastore ds_datos

ls_sel = "SELECT isnull(articulos_etiqueta.etiqueta,'') as etiqueta, "+&
         "       isnull(almetiquetas.descripcion,'') as descripcion, "+&
         "       isnull(almetiquetas.observaciones,'') as observaciones "+&
    		"FROM articulos_etiqueta LEFT OUTER JOIN almetiquetas ON articulos_etiqueta.empresa = almetiquetas.empresa AND articulos_etiqueta.etiqueta = almetiquetas.codigo "+&
   		"WHERE ( articulos_etiqueta.empresa  = '"+codigo_empresa+"' ) "+&
			"AND   ( articulos_etiqueta.articulo = '"+ls_articulo+"' ) "+&
			"ORDER BY isnull(almetiquetas.descripcion,'')"
			
ll_total = f_cargar_cursor_transaccion(sqlca,ds_datos,ls_sel)

for ll_indice = 1 to ll_total
	ls_descripcion_etiqueta = '['+ds_datos.object.etiqueta[ll_indice]+'] '+ds_datos.object.descripcion[ll_indice]
	ddlb_tipo_etiqueta.AddItem (ls_descripcion_etiqueta)
next

ddlb_tipo_etiqueta.SelectItem (1)

destroy ds_datos

end subroutine

on w_impresion_etiquetas_ean128.create
this.st_4=create st_4
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.st_articulo=create st_articulo
this.em_calibre=create em_calibre
this.em_tono=create em_tono
this.uo_calidad=create uo_calidad
this.uo_articulo=create uo_articulo
this.pb_imprimir=create pb_imprimir
this.ddlb_tipo_etiqueta=create ddlb_tipo_etiqueta
this.gb_1=create gb_1
this.Control[]={this.st_4,&
this.st_3,&
this.st_2,&
this.st_1,&
this.st_articulo,&
this.em_calibre,&
this.em_tono,&
this.uo_calidad,&
this.uo_articulo,&
this.pb_imprimir,&
this.ddlb_tipo_etiqueta,&
this.gb_1}
end on

on w_impresion_etiquetas_ean128.destroy
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.st_articulo)
destroy(this.em_calibre)
destroy(this.em_tono)
destroy(this.uo_calidad)
destroy(this.uo_articulo)
destroy(this.pb_imprimir)
destroy(this.ddlb_tipo_etiqueta)
destroy(this.gb_1)
end on

type st_4 from statictext within w_impresion_etiquetas_ean128
integer x = 2944
integer y = 92
integer width = 265
integer height = 88
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Etiqueta:"
boolean focusrectangle = false
end type

type st_3 from statictext within w_impresion_etiquetas_ean128
integer x = 2597
integer y = 92
integer width = 238
integer height = 88
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Calibre:"
boolean focusrectangle = false
end type

type st_2 from statictext within w_impresion_etiquetas_ean128
integer x = 1925
integer y = 92
integer width = 155
integer height = 88
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Lote:"
boolean focusrectangle = false
end type

type st_1 from statictext within w_impresion_etiquetas_ean128
integer x = 1522
integer y = 92
integer width = 251
integer height = 88
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Calidad:"
boolean focusrectangle = false
end type

type st_articulo from statictext within w_impresion_etiquetas_ean128
integer x = 64
integer y = 92
integer width = 251
integer height = 88
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Articulo:"
boolean focusrectangle = false
end type

type em_calibre from u_em_campo within w_impresion_etiquetas_ean128
integer x = 2843
integer y = 80
integer width = 91
integer height = 100
integer taborder = 20
maskdatatype maskdatatype = numericmask!
string mask = "##"
string displaydata = "~r"
end type

type em_tono from u_em_campo within w_impresion_etiquetas_ean128
integer x = 2089
integer y = 80
integer width = 498
integer height = 100
integer taborder = 0
alignment alignment = center!
boolean displayonly = true
maskdatatype maskdatatype = numericmask!
string mask = "##"
string displaydata = ""
end type

type uo_calidad from u_em_campo_2 within w_impresion_etiquetas_ean128
integer x = 1783
integer y = 80
integer width = 133
integer height = 100
integer taborder = 10
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;uo_calidad.em_campo.text=f_nombre_calidad_abr(codigo_empresa,uo_calidad.em_codigo.text)
IF Trim(uo_calidad.em_campo.text)="" THEN 
 IF Trim(uo_calidad.em_codigo.text)<>"" Then uo_calidad.em_campo.SetFocus()
 uo_calidad.em_campo.text=""
 uo_calidad.em_codigo.text=""
END IF

end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de calidad"
ue_datawindow = "dw_ayuda_calidades"
ue_filtro     = ""

end event

on uo_calidad.destroy
call u_em_campo_2::destroy
end on

type uo_articulo from u_em_campo_2 within w_impresion_etiquetas_ean128
integer x = 325
integer y = 80
integer width = 1189
integer height = 100
boolean enabled = false
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;uo_articulo.em_campo.text=f_nombre_articulo(codigo_empresa,uo_articulo.em_codigo.text)
IF Trim(uo_articulo.em_campo.text)="" THEN 
 IF Trim(uo_articulo.em_codigo.text)<>"" Then uo_articulo.em_campo.SetFocus()
 uo_articulo.em_campo.text=""
 uo_articulo.em_codigo.text=""
END IF


end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de articulos"
ue_datawindow = "dw_ayuda_articulos"
ue_filtro     = ""

end event

on uo_articulo.destroy
call u_em_campo_2::destroy
end on

type pb_imprimir from picturebutton within w_impresion_etiquetas_ean128
integer x = 4617
integer y = 28
integer width = 220
integer height = 192
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "Print!"
alignment htextalign = left!
end type

event clicked;string ls_codigo_etiqueta,ls_etiqueta,ls_ruta_etiquetas,ls_comando,ls_Item

ls_Item = ddlb_tipo_etiqueta.text

ls_codigo_etiqueta = mid(ls_Item,2,pos(ls_Item,"]")-2)

SELECT almetiquetas.ruta
into   :ls_etiqueta
FROM   almetiquetas 
WHERE  almetiquetas.empresa = :codigo_empresa 
AND    almetiquetas.codigo  = :ls_codigo_etiqueta;
	
select ruta_etiquetas
into  :ls_ruta_etiquetas
from  empresas
where empresa = :codigo_empresa;

//Updatear los datos en la ot
string ls_articulo,ls_ean13_articulo,ls_calidad,ls_lote,ls_ean128
int    li_calibre

ls_articulo = uo_articulo.em_codigo.text

select isnull(articulos.ean13,'')
into   :ls_ean13_articulo
from   articulos
where  articulos.empresa = :codigo_empresa 
and    articulos.codigo  = :ls_articulo;

ls_calidad = uo_calidad.em_codigo.text
ls_lote    = em_tono.text
li_calibre = integer(em_calibre.text)
//(01)Ean13
//(10)Numero de Lote
//(91)Calidad
//(92)Calibre

ls_ean128  = "(01)"+ls_ean13_articulo+&
				 "(10)"+ls_lote+&
				 "(91)"+ls_calidad+&
				 "(92)"+string(li_calibre,"0")

UPDATE planificacion
SET    planificacion.calidad = :ls_calidad, 
		 planificacion.lote    = :ls_lote, 
		 planificacion.calibre = :li_calibre, 
		 planificacion.ean128  = :ls_ean128 
WHERE  planificacion.empresa = :codigo_empresa
AND    planificacion.ot      = :il_ot;

commit;

ls_comando = '"c:\Program Files (x86)\Labeljoy 5\Labeljoy5.exe" '+ls_ruta_etiquetas+ls_etiqueta
run (ls_comando, Maximized!)
end event

type ddlb_tipo_etiqueta from dropdownlistbox within w_impresion_etiquetas_ean128
integer x = 3218
integer y = 80
integer width = 1367
integer height = 400
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
end type

type gb_1 from groupbox within w_impresion_etiquetas_ean128
integer x = 14
integer width = 4599
integer height = 232
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Datos Etiquetas"
end type

