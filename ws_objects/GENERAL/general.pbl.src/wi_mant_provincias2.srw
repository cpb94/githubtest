$PBExportHeader$wi_mant_provincias2.srw
forward
global type wi_mant_provincias2 from wi_mant_ventanas
end type
type st_2 from statictext within wi_mant_provincias2
end type
type em_pais from u_em_campo within wi_mant_provincias2
end type
type st_nompais from statictext within wi_mant_provincias2
end type
end forward

global type wi_mant_provincias2 from wi_mant_ventanas
integer x = 0
integer y = 0
integer width = 2185
integer height = 1056
st_2 st_2
em_pais em_pais
st_nompais st_nompais
end type
global wi_mant_provincias2 wi_mant_provincias2

type variables



end variables

on ue_inserta_fila;call wi_mant_ventanas::ue_inserta_fila;   dw_1.setitem(dw_1.getrow(),"pais",em_pais.text)
   dw_1.setitem(dw_1.getrow(),"provincia",sle_valor.text)

end on

on open;call wi_mant_ventanas::open;istr_parametros.s_titulo_ventana = "Mantenimiento de Provincias"
istr_parametros.s_listado        = "report_provincias"
This.title=istr_parametros.s_titulo_ventana
 // Si recibo el codigo lo visualizo


end on

on ue_activa_claves;call wi_mant_ventanas::ue_activa_claves;em_pais.Enabled = TRUE
end on

on ue_desactiva_claves;call wi_mant_ventanas::ue_desactiva_claves;em_pais.Enabled = FALSE
end on

on ue_recuperar;// Valores Para Funcion de bloqueo.
 titulo       =  This.title
 longitud     =  len(trim(codigo_empresa))
 criterio[1]  =  trim(codigo_empresa)+ space(20-longitud)
 longitud     =  len(Trim(sle_valor.text))
 criterio[2]  =  trim(sle_valor.text)+space(20-longitud)
 seleccion    =  criterio[1]+criterio[2]
 tabla        = "provincias"

 dw_1.Retrieve(em_pais.text,sle_valor.Text)
 CALL Super::ue_recuperar






end on

on wi_mant_provincias2.create
int iCurrent
call super::create
this.st_2=create st_2
this.em_pais=create em_pais
this.st_nompais=create st_nompais
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_2
this.Control[iCurrent+2]=this.em_pais
this.Control[iCurrent+3]=this.st_nompais
end on

on wi_mant_provincias2.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_2)
destroy(this.em_pais)
destroy(this.st_nompais)
end on

type dw_1 from wi_mant_ventanas`dw_1 within wi_mant_provincias2
integer x = 41
integer y = 340
integer width = 1595
integer height = 488
string dataobject = "dw_provincias"
end type

on dw_1::itemfocuschanged;call wi_mant_ventanas`dw_1::itemfocuschanged;String li_codprov
String li_codpais

CHOOSE CASE dw_1.GetColumnName()
CASE "localidad"
  String var_provincia,var_pais
  String     var_postal,var_localidad
  var_pais      = This.GetItemString(This.GetRow(),'pais')
  var_provincia = This.GetItemString(This.GetRow(),'provincia')	
  var_postal    = This.GetItemString(This.GetRow(),'codpostal')	
  var_localidad = This.GetItemString(This.GetRow(),'localidad')
 IF IsNull(var_localidad) Or Trim(var_localidad)="" THEN
  SELECT  codpostales.provincia,codpostales.ciudad  
    INTO  :var_provincia,:var_localidad  
    FROM  codpostales  
   WHERE (codpostales.pais      = :var_pais ) AND  
         (codpostales.codpostal = :var_postal);
   This.SetItem(This.getrow(),"provincia",var_provincia)
   This.SetItem(This.getrow(),"ciudad",var_localidad)   
END IF
END CHOOSE


end on

event dw_1::clicked;call super::clicked;string ls_objeto
datawindow var_datawindow
str_parametros lstr_param
// Devuelve el objeto al que apunta seguido del tabulador (~t) y 
// el numero de fila en la Datawindow

ls_objeto = dw_1.GetObjectAtPointer()
ls_objeto = Left(ls_objeto, Pos(ls_objeto, "~t", 1) - 1)

lstr_param.i_nargumentos    = 2
lstr_param.s_argumentos[1]  = "wi_mant_empresas"

CHOOSE CASE ls_objeto

CASE 'pb_pais'
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"pais")
   OpenWithParm(wi_mant_paises,lstr_param)  
CASE 'pb_provincia'
   lstr_param.i_nargumentos    = 3
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"pais")
   lstr_param.s_argumentos[3]=GetItemString(This.GetRow(),"provincia")
   OpenWithParm(wi_mant_provincias,lstr_param)  
CASE 'pb_codpostal'
   lstr_param.i_nargumentos    = 3
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"pais")
   lstr_param.s_argumentos[3]=GetItemString(This.GetRow(),"provincia")
   OpenWithParm(wi_mant_codpostales,lstr_param)  
  
CASE 'pb_idioma'
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"idioma")
   OpenWithParm(wi_mant_idiomas,lstr_param)  

END CHOOSE

IF trim(em_pais.text)=""  Or trim(st_nompais.text)="" or Not IsNumber(em_pais.text) THEN 
	f_activar_campo(em_pais)
end if




end event

type st_1 from wi_mant_ventanas`st_1 within wi_mant_provincias2
integer y = 204
integer width = 306
integer height = 88
string text = "Provincia:"
end type

type cb_insertar from wi_mant_ventanas`cb_insertar within wi_mant_provincias2
integer x = 1673
integer y = 340
end type

type cb_borrar from wi_mant_ventanas`cb_borrar within wi_mant_provincias2
integer x = 1673
integer y = 468
end type

type sle_valor from wi_mant_ventanas`sle_valor within wi_mant_provincias2
integer x = 430
integer y = 204
integer taborder = 20
boolean bringtotop = true
end type

event sle_valor::getfocus;call super::getfocus;valor_empresa = FALSE
ue_titulo    	= "AYUDA SELECCION DE PROVINCIAS"
ue_datawindow	= "dw_ayuda_provincias"
ue_filtro      = "pais = '" + em_pais.text + "' "
isle_campo     = this

if Trim(em_pais.text)="" or trim(st_nompais.text)="" or IsNull(em_pais.text) &
   or IsNull(st_nompais.text) then f_activar_campo(em_pais)	


end event

type cb_salir from wi_mant_ventanas`cb_salir within wi_mant_provincias2
integer x = 1673
integer y = 596
end type

type control_tabulador from wi_mant_ventanas`control_tabulador within wi_mant_provincias2
integer taborder = 30
end type

type st_2 from statictext within wi_mant_provincias2
integer x = 219
integer y = 76
integer width = 192
integer height = 100
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Pais:"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_pais from u_em_campo within wi_mant_provincias2
integer x = 434
integer y = 72
integer taborder = 10
end type

event getfocus;call super::getfocus;valor_empresa = FALSE
ue_titulo     = "AYUDA SELECCION DE PAISES"
ue_datawindow = "dw_ayuda_paises"
ue_filtro     = ""
isle_campo = this

sle_valor.text= ""
dw_1.retrieve(em_pais.text,sle_valor.text)


   IF istr_parametros.i_nargumentos>1 THEN
 	  em_pais.text=istr_parametros.s_argumentos[2]	
     f_no_nulo(em_pais)
     em_pais.TriggerEvent("modificado")
     sle_valor.text=istr_parametros.s_argumentos[3]
     f_no_nulo(sle_valor)
     sle_valor.TriggerEvent("modificado")
     istr_parametros.i_nargumentos=0
	  IF Trim(sle_valor.text)<>"" and Trim(em_pais.text)<>"" THEN
          Parent.TriggerEvent("ue_recuperar")
			 f_activar_campo(sle_valor)
			 Return
     END IF
     
   END IF
end event

on modificado;call u_em_campo::modificado;st_nompais.text=f_nombre_pais(em_pais.text)	
IF Trim(st_nompais.text)="" THEN 
 IF Trim(em_pais.text)<>"" Then 
  f_activar_campo(em_pais)
 END IF
 em_pais.text=""
END IF


end on

type st_nompais from statictext within wi_mant_provincias2
integer x = 722
integer y = 80
integer width = 718
integer height = 72
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

