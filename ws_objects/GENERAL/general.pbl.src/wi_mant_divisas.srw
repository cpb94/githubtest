$PBExportHeader$wi_mant_divisas.srw
forward
global type wi_mant_divisas from wi_mant_ventanas
end type
type pb_calculadora from u_calculadora within wi_mant_divisas
end type
end forward

global type wi_mant_divisas from wi_mant_ventanas
integer x = 0
integer y = 0
integer width = 2473
integer height = 996
pb_calculadora pb_calculadora
end type
global wi_mant_divisas wi_mant_divisas

type variables



end variables

event open;call super::open;istr_parametros.s_titulo_ventana = "Mantenimiento de Divisas"
istr_parametros.s_listado        = "report_divisas"

This.title=istr_parametros.s_titulo_ventana

 // Si recibo el codigo lo visualizo
IF istr_parametros.i_nargumentos>1 THEN
     sle_valor.text=istr_parametros.s_argumentos[2]
     istr_parametros.i_nargumentos=0
	  IF TRIM(sle_valor.text)<>"" AND Not IsNull(sle_valor.text) THEN
        	This.TriggerEvent("ue_recuperar")
			Return
     END IF
END IF
end event

on ue_desactiva_claves;call wi_mant_ventanas::ue_desactiva_claves;pb_calculadora.visible = FALSE
end on

event ue_inserta_fila;call super::ue_inserta_fila;dw_1.setitem(dw_1.getrow(),"moneda",sle_valor.text)
dw_1.setitem(dw_1.getrow(),"genero",1)
end event

on ue_recuperar;// Valores Para Funcion de bloqueo
 titulo       = This.title
 longitud     =  len(trim(codigo_empresa))
 criterio[1]  =  trim(codigo_empresa)+ space(20-longitud)
 longitud     =  len(Trim(sle_valor.text))
 criterio[2]  =  trim(sle_valor.text)+space(20-longitud)
 seleccion    =  criterio[1]+criterio[2]
 tabla        = "divisas"
 dw_1.Retrieve(sle_valor.Text)
 CALL Super::ue_recuperar






end on

on wi_mant_divisas.create
int iCurrent
call super::create
this.pb_calculadora=create pb_calculadora
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_calculadora
end on

on wi_mant_divisas.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_calculadora)
end on

on ue_activa_claves;call wi_mant_ventanas::ue_activa_claves;pb_calculadora.visible = TRUE
end on

type dw_1 from wi_mant_ventanas`dw_1 within wi_mant_divisas
integer x = 50
integer y = 204
integer width = 1806
integer height = 568
string dataobject = "dw_divisas"
end type

event dw_1::clicked;call super::clicked;str_parametros lstr_param

lstr_param.i_nargumentos    = 2
lstr_param.s_argumentos[1]  = "wi_mant_divisas"

CHOOSE CASE f_objeto_datawindow(dw_1)

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





end event

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

event dw_1::editchanged;dec cambio_euros_div,cambio_euros_pts
string columna

columna = this.GetColumnName( )

if columna = "euros" then
	this.accepttext()
	cambio_euros_div = this.getitemdecimal(this.getrow(),"euros")
	if cambio_euros_div <> 0 then
		cambio_euros_pts = f_cambio_euros("1")
		this.setitem(this.getrow(),"cotizacion", cambio_euros_pts / cambio_euros_div)
	end if
end if
end event

type st_1 from wi_mant_ventanas`st_1 within wi_mant_divisas
integer x = 279
integer y = 76
integer width = 274
integer height = 88
string text = "Código"
end type

type cb_insertar from wi_mant_ventanas`cb_insertar within wi_mant_divisas
integer x = 1929
integer y = 212
end type

event cb_insertar::clicked;call super::clicked;Integer resp
DateTime ahora
real cotiz

resp = MessageBox("Guardar datos divisa","¿Desea que la cotización que se está almacenando se guarde también en el histórico de divisas?", Question!, YesNo!, 1)
if resp = 1 then
	// Insertar cotización en el histórico de divisas
   ahora = DateTime(Today(),Now())
	cotiz = dw_1.GetItemNumber(1,"cotizacion")
	INSERT INTO hisdivisas (fecha,divisa,cotizacion)
	  VALUES (:ahora,:sle_valor.text,:cotiz)
	  USING sqlca;

	// El COMMIT ya lo hará la ventana padre...
	IF sqlca.sqlcode <> 0 then
		f_mensaje("Inserción en histórico de divisas","Error: "+sqlca.sqlerrtext)
	END IF
end if
end event

type cb_borrar from wi_mant_ventanas`cb_borrar within wi_mant_divisas
integer x = 1929
integer y = 340
end type

type sle_valor from wi_mant_ventanas`sle_valor within wi_mant_divisas
integer x = 558
integer y = 76
boolean bringtotop = true
end type

event sle_valor::getfocus;call super::getfocus;valor_empresa = FALSE
ue_titulo     = "AYUDA SELECCION DE DIVISAS"
ue_datawindow = "dw_ayuda_divisas"
ue_filtro     = ""

end event

type cb_salir from wi_mant_ventanas`cb_salir within wi_mant_divisas
integer x = 1929
integer y = 468
end type

type control_tabulador from wi_mant_ventanas`control_tabulador within wi_mant_divisas
end type

type pb_calculadora from u_calculadora within wi_mant_divisas
integer x = 827
integer y = 68
integer width = 119
integer height = 104
integer taborder = 0
string picturename = "c:\bmp\calcula.bmp"
end type

on clicked;call u_calculadora::clicked;IF cb_insertar.enabled=TRUE THEN Return
Integer registros
Select count(*) Into :registros From monedas;

IF registros=0  Then
   sle_valor.text="1"
 ELSE
   Select max(convert(int,monedas.moneda)+1) 
   Into   :sle_valor.text
   From   monedas;
END IF
dw_1.TriggerEvent("Clicked")
end on

