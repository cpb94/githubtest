$PBExportHeader$wi_mant_utidiccionario.srw
forward
global type wi_mant_utidiccionario from wi_mvent_con_empresa
end type
type st_almacen from statictext within wi_mant_utidiccionario
end type
type sle_frase from u_em_campo within wi_mant_utidiccionario
end type
type st_nombre_idioma from statictext within wi_mant_utidiccionario
end type
type gb_1 from groupbox within wi_mant_utidiccionario
end type
end forward

global type wi_mant_utidiccionario from wi_mvent_con_empresa
integer width = 2601
integer height = 1144
st_almacen st_almacen
sle_frase sle_frase
st_nombre_idioma st_nombre_idioma
gb_1 gb_1
end type
global wi_mant_utidiccionario wi_mant_utidiccionario

type variables

end variables

forward prototypes
public subroutine f_control ()
end prototypes

public subroutine f_control ();dw_1.Retrieve(sle_frase.text,sle_valor.Text)


end subroutine

event open;call super::open;istr_parametros.s_titulo_ventana = "Mantenimiento de diccionario"
istr_parametros.s_listado        = "report_utidiccionario"
valor_empresa = FALSE
This.title=istr_parametros.s_titulo_ventana


end event

event ue_inserta_fila;call super::ue_inserta_fila;dw_1.setitem(dw_1.getrow(),"texto_castellano",sle_frase.text)
dw_1.setitem(dw_1.getrow(),"idioma",sle_valor.text)

end event

event ue_recuperar;// Valores Para Funcion de bloqueo
titulo        = This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(sle_frase.text))
criterio[2]   =  trim(sle_frase.text)+space(20-longitud)
longitud      =  len(trim(sle_valor.text))
criterio[3]   =  trim(sle_valor.text)+space(20-longitud)
seleccion     =  criterio[1]+criterio[2]+criterio[3]
tabla         =  "utidiccionario"


f_control()

CALL Super::ue_recuperar
end event

event ue_desactiva_claves;call super::ue_desactiva_claves;sle_frase.enabled=FALSE
end event

on wi_mant_utidiccionario.create
int iCurrent
call super::create
this.st_almacen=create st_almacen
this.sle_frase=create sle_frase
this.st_nombre_idioma=create st_nombre_idioma
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_almacen
this.Control[iCurrent+2]=this.sle_frase
this.Control[iCurrent+3]=this.st_nombre_idioma
this.Control[iCurrent+4]=this.gb_1
end on

on wi_mant_utidiccionario.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_almacen)
destroy(this.sle_frase)
destroy(this.st_nombre_idioma)
destroy(this.gb_1)
end on

event ue_activa_claves;call super::ue_activa_claves;sle_frase.enabled=TRUE
end event

type dw_1 from wi_mvent_con_empresa`dw_1 within wi_mant_utidiccionario
integer x = 14
integer y = 448
integer width = 2386
integer height = 260
string dataobject = "dw_utidiccionario"
end type

type st_1 from wi_mvent_con_empresa`st_1 within wi_mant_utidiccionario
integer x = 279
integer y = 320
integer width = 242
integer height = 80
string text = "Idioma:"
alignment alignment = right!
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within wi_mant_utidiccionario
integer x = 1157
integer y = 744
end type

type cb_borrar from wi_mvent_con_empresa`cb_borrar within wi_mant_utidiccionario
integer x = 1568
integer y = 744
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within wi_mant_utidiccionario
integer x = 567
integer y = 312
integer width = 219
integer height = 92
integer taborder = 20
fontfamily fontfamily = roman!
string facename = "Times New Roman"
end type

event sle_valor::getfocus;call super::getfocus;ue_titulo       	= "AYUDA SELECCION DE IDOMAS "
ue_datawindow   	= "dw_ayuda_idiomas"
ue_filtro 		   = "" 
isle_campo        = sle_valor
valor_empresa  = FALSE

IF trim(sle_frase.text)= "" THEN f_activar_campo(sle_frase)
IF trim(sle_valor.text)  = "" THEN f_control()

end event

event sle_valor::modificado;call super::modificado;st_nombre_idioma.text=f_nombre_idioma(sle_valor.text)
IF Trim(st_nombre_idioma.text)="" THEN 
 IF Trim(sle_valor.text)<>"" Then  f_activar_campo(sle_valor)
 sle_valor.text=""
END IF
end event

type cb_salir from wi_mvent_con_empresa`cb_salir within wi_mant_utidiccionario
integer x = 1979
integer y = 744
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within wi_mant_utidiccionario
integer taborder = 30
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within wi_mant_utidiccionario
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within wi_mant_utidiccionario
end type

type st_almacen from statictext within wi_mant_utidiccionario
integer x = 41
integer y = 196
integer width = 507
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Frase castellano:"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_frase from u_em_campo within wi_mant_utidiccionario
integer x = 567
integer y = 188
integer width = 1783
integer height = 92
integer taborder = 10
fontfamily fontfamily = roman!
string facename = "Times New Roman"
textcase textcase = anycase!
string mask = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
string displaydata = "~r"
end type

event getfocus;call super::getfocus;  	   ue_titulo     = ""
		ue_datawindow = ""
		ue_filtro     = ""
      isle_campo    = sle_frase
      f_control()
   
        
 IF istr_parametros.i_nargumentos>1 THEN
	  sle_frase.text=istr_parametros.s_argumentos[2]	
     f_no_nulo(sle_frase)
     sle_valor.text=istr_parametros.s_argumentos[3]
     f_no_nulo(sle_valor)
     sle_valor.TriggerEvent("modificado")
     IF Trim(sle_valor.text)<>"" and Trim(sle_frase.text)<>"" THEN
          dw_1.retrieve(sle_frase.text,sle_valor.text)
         
     END IF
     istr_parametros.i_nargumentos=0
    END IF







end event

type st_nombre_idioma from statictext within wi_mant_utidiccionario
integer x = 818
integer y = 324
integer width = 535
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
boolean focusrectangle = false
end type

type gb_1 from groupbox within wi_mant_utidiccionario
integer x = 1147
integer y = 708
integer width = 1257
integer height = 144
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
end type

