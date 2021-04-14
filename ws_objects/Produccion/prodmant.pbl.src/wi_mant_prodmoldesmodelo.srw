$PBExportHeader$wi_mant_prodmoldesmodelo.srw
forward
global type wi_mant_prodmoldesmodelo from wi_mvent_con_empresa
end type
type st_almacen from statictext within wi_mant_prodmoldesmodelo
end type
type st_nombre_articulo from statictext within wi_mant_prodmoldesmodelo
end type
type sle_articulo from u_em_campo within wi_mant_prodmoldesmodelo
end type
type st_nombre_calidad from statictext within wi_mant_prodmoldesmodelo
end type
type st_formato from statictext within wi_mant_prodmoldesmodelo
end type
end forward

global type wi_mant_prodmoldesmodelo from wi_mvent_con_empresa
int Width=3031
int Height=992
st_almacen st_almacen
st_nombre_articulo st_nombre_articulo
sle_articulo sle_articulo
st_nombre_calidad st_nombre_calidad
st_formato st_formato
end type
global wi_mant_prodmoldesmodelo wi_mant_prodmoldesmodelo

type variables

end variables

forward prototypes
public subroutine f_control ()
end prototypes

public subroutine f_control ();dw_1.Retrieve(codigo_empresa,sle_articulo.text,f_formato_molde(codigo_empresa,sle_articulo.text),sle_valor.Text)


end subroutine

event open;call super::open;istr_parametros.s_titulo_ventana = "Mantenimiento de Moldes por Modelo"
This.title=istr_parametros.s_titulo_ventana

end event

event ue_inserta_fila;call super::ue_inserta_fila;dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
dw_1.setitem(dw_1.getrow(),"codigo",sle_articulo.text)
dw_1.setitem(dw_1.getrow(),"formato",f_formato_molde(codigo_empresa,sle_articulo.text))
dw_1.setitem(dw_1.getrow(),"tipo",sle_valor.text)
dw_1.setitem(dw_1.getrow(),"espesor",0)

end event

event ue_recuperar;// Valores Para Funcion de bloqueo
titulo        =  This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(sle_articulo.text))
criterio[2]   =  trim(sle_articulo.text)+space(20-longitud)
longitud      =  len(trim(sle_valor.text))
criterio[3]   =  trim(sle_valor.text)+space(20-longitud)
seleccion     =  criterio[1]+criterio[2]+criterio[3]
tabla         =  "prodmoldesmodelo"


f_control()

CALL Super::ue_recuperar
end event

on ue_desactiva_claves;call wi_mvent_con_empresa::ue_desactiva_claves;sle_articulo.enabled=FALSE
end on

on wi_mant_prodmoldesmodelo.create
int iCurrent
call super::create
this.st_almacen=create st_almacen
this.st_nombre_articulo=create st_nombre_articulo
this.sle_articulo=create sle_articulo
this.st_nombre_calidad=create st_nombre_calidad
this.st_formato=create st_formato
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_almacen
this.Control[iCurrent+2]=this.st_nombre_articulo
this.Control[iCurrent+3]=this.sle_articulo
this.Control[iCurrent+4]=this.st_nombre_calidad
this.Control[iCurrent+5]=this.st_formato
end on

on wi_mant_prodmoldesmodelo.destroy
call super::destroy
destroy(this.st_almacen)
destroy(this.st_nombre_articulo)
destroy(this.sle_articulo)
destroy(this.st_nombre_calidad)
destroy(this.st_formato)
end on

on ue_activa_claves;call wi_mvent_con_empresa::ue_activa_claves;sle_articulo.enabled=TRUE
end on

type dw_1 from wi_mvent_con_empresa`dw_1 within wi_mant_prodmoldesmodelo
int X=59
int Y=448
int Width=2295
int Height=304
string DataObject="dw_prodmoldesmoldelo"
end type

type st_1 from wi_mvent_con_empresa`st_1 within wi_mant_prodmoldesmodelo
int X=256
int Y=312
int Width=265
int Height=80
boolean BringToTop=true
string Text="Modelo :"
Alignment Alignment=Right!
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within wi_mant_prodmoldesmodelo
int X=2414
int Y=344
end type

type cb_borrar from wi_mvent_con_empresa`cb_borrar within wi_mant_prodmoldesmodelo
int X=2414
int Y=472
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within wi_mant_prodmoldesmodelo
int X=567
int Y=312
int Width=219
int Height=92
int TabOrder=20
boolean BringToTop=true
string FaceName="Times New Roman"
FontFamily FontFamily=Roman!
FontPitch FontPitch=Variable!
end type

event sle_valor::getfocus;call super::getfocus;ue_titulo         = "AYUDA SELECCION MODELOS"
ue_datawindow     = "dw_ayuda_modelo"
ue_filtro         =  ""
isle_campo        = sle_valor

IF trim(sle_articulo.text)= "" THEN f_activar_campo(sle_articulo)
//IF trim(sle_valor.text)  = "" THEN f_control()

end event

event sle_valor::modificado;call super::modificado;st_nombre_calidad.text=f_nombre_modelos(codigo_empresa,sle_valor.text)
IF Trim(st_nombre_calidad.text)="" THEN 
 IF Trim(sle_valor.text)<>"" Then  f_activar_campo(sle_valor)
 sle_valor.text=""
END IF
end event

type cb_salir from wi_mvent_con_empresa`cb_salir within wi_mant_prodmoldesmodelo
int X=2414
int Y=600
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within wi_mant_prodmoldesmodelo
int TabOrder=30
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within wi_mant_prodmoldesmodelo
int Width=2807
boolean BringToTop=true
end type

type st_almacen from statictext within wi_mant_prodmoldesmodelo
int X=256
int Y=188
int Width=265
int Height=80
boolean Enabled=false
boolean BringToTop=true
string Text="Molde :"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_nombre_articulo from statictext within wi_mant_prodmoldesmodelo
int X=818
int Y=188
int Width=1056
int Height=92
boolean Enabled=false
boolean BringToTop=true
boolean Border=true
BorderStyle BorderStyle=StyleRaised!
boolean FocusRectangle=false
long TextColor=128
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_articulo from u_em_campo within wi_mant_prodmoldesmodelo
int X=567
int Y=188
int Width=219
int Height=92
int TabOrder=10
string FaceName="Times New Roman"
FontFamily FontFamily=Roman!
FontPitch FontPitch=Variable!
end type

event getfocus;call super::getfocus; ue_titulo     = "AYUDA SELECCION DE ARTICULOS"
 ue_datawindow = "dw_ayuda_prodmoldes"
 ue_filtro     = ""
 isle_campo    = sle_articulo
 
 f_control()
 sle_valor.text = ""         
 






end event

event modificado;call super::modificado;st_nombre_articulo.text=f_nombre_molde(codigo_empresa,sle_articulo.text)
st_formato.text = f_nombre_formato(codigo_empresa,f_formato_molde(codigo_empresa,sle_articulo.text))
IF Trim(st_nombre_articulo.text)="" THEN 
 IF Trim(sle_articulo.text)<>"" Then  f_activar_campo(sle_articulo)
 sle_articulo.text=""
END IF
end event

type st_nombre_calidad from statictext within wi_mant_prodmoldesmodelo
int X=818
int Y=312
int Width=1056
int Height=92
boolean Enabled=false
boolean BringToTop=true
boolean Border=true
BorderStyle BorderStyle=StyleRaised!
boolean FocusRectangle=false
long TextColor=128
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_formato from statictext within wi_mant_prodmoldesmodelo
int X=1897
int Y=188
int Width=384
int Height=92
boolean Enabled=false
boolean BringToTop=true
boolean Border=true
BorderStyle BorderStyle=StyleRaised!
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=128
long BackColor=67108864
int TextSize=-10
int Weight=700
string FaceName="Times New Roman"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Roman!
FontPitch FontPitch=Variable!
end type

