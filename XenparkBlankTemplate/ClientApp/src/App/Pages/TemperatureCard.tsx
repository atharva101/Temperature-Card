import {Card,Button,Badge} from 'react-bootstrap'
import ReactSpeedometer from 'react-d3-speedometer'

const TemperatureCard = ({tempValue,status,header,badgeColor, color}:any) => { 
    return(
         <>
            <Card style = {{maxWidth: '370px', marginLeft: '100px', marginRight: '50px'}}>
                <Card.Header style ={{ fontSize: '20px', fontWeight: 'bold'}}>{header}</Card.Header>
                    <Card.Body>
                        <span style = {{display:'flex', height: '170px', flexDirection: 'column', alignItems: 'center', gap: '10px'}}>
                           <ReactSpeedometer 
                             needleTransitionDuration={4000}
                             //@ts-ignore
                             needleTransition= 'easeElastic'
                             needleColor='black'
                             segments= {3}
                             segmentColors ={['yellow','green','green','red']}
                             customSegmentStops ={[0,20,50,80,100]}
                             currentValueText = {`${tempValue}`}
                             minValue={0}
                             maxValue ={100}
                             value = {tempValue}
                             textColor ={'black'}
                             width= {200}
                             height = {125}
                             />
                            <span style = {{backgroundColor: `${badgeColor}`, width: '82px', borderRadius: '7px',textAlign: 'center', color: `${color}`}}>{status}</span>
                        </span>
                        <span style ={{fontSize: '20px', fontWeight: 'bolder', display:'block', textAlign: 'center', marginBottom: '20px'}}>Temperature {tempValue}&deg;c</span>
                        <span style ={{fontSize: '20px', fontWeight: 'bolder'}}>Low  {20}&deg;c</span>
                        <span style ={{marginLeft: '150px',fontSize: '20px', fontWeight: 'bolder'}}>High {80}&deg;c</span>
                    </Card.Body>

            </Card>
        </>
    )
}

export default TemperatureCard;