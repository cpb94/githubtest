$PBExportHeader$w_int_borrado_ventarifas.srw
forward
global type w_int_borrado_ventarifas from w_int_con_empresa
end type
type pb_1 from upb_salir within w_int_borrado_ventarifas
end type
type dw_preliminar from datawindow within w_int_borrado_ventarifas
end type
type pb_2 from upb_papelera within w_int_borrado_ventarifas
end type
type dw_proceso from datawindow within w_int_borrado_ventarifas
end type
end forward

global type w_int_borrado_ventarifas from w_int_con_empresa
integer width = 2994
integer height = 1576
pb_1 pb_1
dw_preliminar dw_preliminar
pb_2 pb_2
dw_proceso dw_proceso
end type
global w_int_borrado_ventarifas w_int_borrado_ventarifas

type variables
string filtro,bloqueado
end variables

forward prototypes
public subroutine f_control ()
public subroutine f_borrar ()
public function boolean f_control_cliente (string tarifa)
end prototypes

public subroutine f_control ();dw_preliminar.Retrieve(codigo_empresa)


end subroutine

public subroutine f_borrar ();Integer bien,registros,registro
String var_tarifa,var_articulo,var_calidad
DateTime var_fecha
bien = 0
var_tarifa = dw_preliminar.GetItemString(dw_preliminar.GetRow(),"tarifa")
var_fecha  = dw_preliminar.GetItemDateTime(dw_preliminar.GetRow(),"fecha")

IF  MessageBox("Tarifa " + f_nombre_ventarifa(codigo_empresa,var_tarifa)+ "  " + String(var_fecha,"dd-mm-yy"),"Desea borrar la tarifa? ",Question!, YesNo!,2) = 1 Then
IF f_activa_ventarifas(codigo_empresa,var_tarifa) = var_fecha Then	
 IF f_control_cliente(var_tarifa) Then
   IF  MessageBox("Existen clientes con esta tarifa asignada","Desea borrar la tarifa? ",Question!, YesNo!,2) = 2 Then	
 	  Return
   END IF
 END IF
END IF
		
 titulo        =  w_int_borrado_ventarifas.title
 longitud      =  len(trim(codigo_empresa))
 criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
 longitud      =  len(trim(var_tarifa))
 criterio[2]   =  trim(var_tarifa)+space(20-longitud)
 longitud      =  len(trim(String(var_fecha)))
 criterio[3]   =  trim(String(var_fecha))+space(20-longitud)
 seleccion     =  criterio[1]+criterio[2]+criterio[3]
 tabla         =  "venmapatarifas"

 IF NOT f_bloquear(tabla,seleccion,titulo) THEN
  COMMIT Using SQLCA; //Solucion nivel insolacion
  bloqueado = "S"
  registros  = dw_proceso.Retrieve(codigo_empresa,var_tarifa,var_fecha)
  FOR registro = 1 To registros
	 var_articulo  =  dw_proceso.GetItemString(registro,"articulo")
	 var_calidad   =  dw_proceso.GetItemString(registro,"calidad")
	  DELETE FROM venlintarifas  
     WHERE ( venlintarifas.empresa = :codigo_empresa ) AND  
           ( venlintarifas.tarifa = :var_tarifa ) AND  
           ( venlintarifas.fecha = :var_fecha ) AND  
           ( venlintarifas.articulo = :var_articulo ) AND  
           ( venlintarifas.calidad = :var_calidad )   ;
           IF Sqlca.SqlCode <> 0 Then bien = 1
			  f_contador_procesos(registro,registros)
NEXT	
  DELETE FROM venmapatarifas  
   WHERE ( venmapatarifas.empresa = :codigo_empresa ) AND  
         ( venmapatarifas.tarifa = :var_tarifa ) AND  
         ( venmapatarifas.fecha = :var_fecha )   ;
			IF Sqlca.SqlCode <> 0 Then bien = 1
			

If bien =0 Then
	 f_mensaje("Proceso finalizado"," Operacion finalizada con exito")
	 COMMIT;
Else
	 f_mensaje("Error en proceso"," La Operacion no se actualiza")
  	 ROLLBACK;
END IF	
 f_desbloquear(tabla,seleccion,titulo)
 COMMIT using sqlca;
 bloqueado="N"
 f_control()	
END IF
END IF
end subroutine

public function boolean f_control_cliente (string tarifa);Integer numero
  SELECT count(*)  
    INTO :numero  
    FROM venclientes  
   WHERE ( venclientes.empresa = '.codigo_empresa' ) AND  
         ( venclientes.tarifa = :tarifa )   ;
	If ISNull(numero ) Then numero = 0
	If numero <> 0 Then
		 Return FALSE
	ELse
		Return TRUE
	End If


end function

event open;call super::open;istr_parametros.s_titulo_ventana="Proceso de bajas de tarifas"
This.title=istr_parametros.s_titulo_ventana
dw_preliminar.SetTransObject(SQLCA)
dw_proceso.SetTransObject(SQLCA)
bloqueado = "N"
dw_preliminar.SetRowFocusIndicator(Hand!)

f_control()
If dw_preliminar.RowCount() <> 0 then dw_preliminar.SetRow(1)
end event

on ue_listar;//dw_report  = dw_detalle
//dw_report.SetTransObject(SQLCA)
//Datetime fecha
//fecha = DateTime(Date(String(sle_fecha.Text)))
//dw_report.retrieve(codigo_empresa,em_tarifa.text,fecha)
//IF TRIM(filtro)<>"" THEN
// dw_report.SetFilter(filtro)
// dw_report.Filter()
//END IF
//CALL Super::ue_listar
end on

on w_int_borrado_ventarifas.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.dw_preliminar=create dw_preliminar
this.pb_2=create pb_2
this.dw_proceso=create dw_proceso
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.dw_preliminar
this.Control[iCurrent+3]=this.pb_2
this.Control[iCurrent+4]=this.dw_proceso
end on

on w_int_borrado_ventarifas.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.dw_preliminar)
destroy(this.pb_2)
destroy(this.dw_proceso)
end on

event close;call super::close;If bloqueado="S" Then 
 f_desbloquear(tabla,seleccion,titulo)
 COMMIT using sqlca;
 bloqueado="N"
End IF
end event

event activate;call super::activate;w_int_borrado_ventarifas = ventanas_activas[id_ventana_activa].ventana
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_int_borrado_ventarifas
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_int_borrado_ventarifas
end type

type st_empresa from w_int_con_empresa`st_empresa within w_int_borrado_ventarifas
integer x = 27
integer y = 8
integer width = 2427
end type

type pb_1 from upb_salir within w_int_borrado_ventarifas
integer x = 2784
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
string picturename = "exit!"
end type

type dw_preliminar from datawindow within w_int_borrado_ventarifas
integer y = 284
integer width = 2898
integer height = 1028
integer taborder = 10
string dataobject = "dw_int_borrar_ventarifas"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

type pb_2 from upb_papelera within w_int_borrado_ventarifas
integer x = 5
integer y = 128
integer width = 183
integer height = 160
integer taborder = 50
end type

event clicked;call super::clicked;IF dw_preliminar.GetRow()=0 then Return

f_borrar()

end event

type dw_proceso from datawindow within w_int_borrado_ventarifas
boolean visible = false
integer x = 462
integer y = 12
integer width = 494
integer height = 120
integer taborder = 1
boolean bringtotop = true
string dataobject = "dw_proceso_venlintarifas"
boolean livescroll = true
end type

